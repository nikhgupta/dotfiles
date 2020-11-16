var AlfredNode = require('alfred-workflow-nodejs');
var OpenSubtitles = require('opensubtitles-api');
var path = require("path");
var omdb = require('omdb');
var http = require('http');
var url = require('url');
var async = require('async');
var actionHandler = AlfredNode.actionHandler;
var workflow = AlfredNode.workflow;
var Item = AlfredNode.Item;

workflow.setName('iris');

(function main()
{
    /*
    |--------------------------------------------------------------------------
    | Search Action
    |--------------------------------------------------------------------------
    |
    | This action search on OMDB for a given name and
    | return the item with the imdb id as argument
    |
    */
    actionHandler.onAction('search', function(query)
    {
        omdb.search(query, function(error, movies)
        {
            if (movies.length)
            {
                async.each(movies, function(movie, callback)
                {
                    var parameters = { imdb: movie.imdb };

                    omdb.get(parameters, true, function(error, movie)
                    {
                        var subtitle = [];
                        if (movie.runtime) subtitle.push(movie.runtime + ' min');
                        if (movie.metacritic) subtitle.push('Metascore: ' + movie.metacritic);
                        if (movie.imdb['rating']) subtitle.push('Rating: ' + movie.imdb['rating']);
                        if (Object.keys(movie.year).length) movie.year = movie.year.from;

                        var item = new Item({
                            title: movie.title + ' (' + movie.year + ')',
                            subtitle: subtitle.join(' | '),
                            arg: movie.imdb['id'],
                            icon: 'imdb.png',
                            valid: true
                        });

                        workflow.addItem(item);
                        callback();
                    });

                }, function (error) {
                    if (error) console.error(error.message);
                    onFinished();
                });
            }
            else
            {
                var item = new Item({
                    title: '"' + query.replace(/\\/g, '') + '" sleep with the fishes...',
                    valid: true
                });

                workflow.addItem(item);
                workflow.feedback();
            }
        });

        function onFinished()
        {
            workflow.feedback();
        }
    });

    /*
    |--------------------------------------------------------------------------
    | Subtitles Action
    |--------------------------------------------------------------------------
    |
    | This action search on OpenSubtitles for imdb id or file
    | and returns a list of the found languages
    |
    */
    actionHandler.onAction('subtitles', function(query)
    {
        var OS = new OpenSubtitles('Alfred OpenSubtitles');
        var filePath = '';
        var fileName = '';
        var qs = {};
        // qs['limit'] = 'all';

        var pathObject = path.parse(query)
        var isFile = pathObject.root;

        var isImdbSearch = new RegExp("tt\\d{7}").test(query);

        if (isFile)
        {
            qs['path'] = query;
            filePath = pathObject.dir;
            fileName = pathObject.name;
        }
        else if (isImdbSearch)
        {
            qs['imdbid'] = query;
            filePath = '~/Downloads';
            fileName = query;
        }
        else
        {
            qs['query'] = query;
            filePath = '~/Downloads';
            fileName = query;
        }

        OS.search(qs).then(function(subtitles)
        {
            if (Object.keys(subtitles).length)
            {
                for (var lang in subtitles)
                {
                    var item = new Item({
                        title: subtitles[lang].langName,
                        arg: {
                            arg: subtitles[lang].url,
                            variables: {
                                path: filePath,
                                name: fileName,
                                encoding: subtitles[lang].encoding
                            }
                        },
                        icon: 'download.png',
                        valid: true
                    })

                    workflow.addItem(item);
                }
            }
            else
            {
                var item = new Item({
                    title: 'No subtitles found',
                    valid: true
                });

                workflow.addItem(item);
            }

            workflow.feedback();
        });
    });

    /*
    |--------------------------------------------------------------------------
    | Download Action
    |--------------------------------------------------------------------------
    |
    | This action gets the content of a given url
    | and return it
    |
    */
    actionHandler.onAction('download', function(query)
    {
        var options = {
            host: url.parse(query).host,
            path: url.parse(query).path,
        };

        http.get(options, function(response)
        {
            var data = '';

            response.setEncoding('binary');

            response.on('data', function(chunk) {
                data += chunk;
            });

            response.on('end', function()
            {
                AlfredNode.utils.generateVars({
                    variables: {
                        content: data
                    }
                });
            });

            response.on('error', function(e) {
                console.log(e.message);
            });
        });
    });

    AlfredNode.run();
})();
