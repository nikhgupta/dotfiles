require(["nbextensions/snippets_menu/main"], function (snippets_menu) {
  console.log('Loading `snippets_menu` customizations from `custom.js`');
  var horizontal_line = '---';
  var my_favorites = {
    'name' : 'Backfolio',
    'sub-menu' : [
      {
        'name' : 'Initialization Code',
        'snippet' : [
          "%run ../startup.py",
          "%run ../coinalgo.py",
          "rcParams['figure.figsize'] = 12,8"
        ],
      },
      {
        'name' : 'Datacenter - Standalone Usage',
        'snippet' : [
          "from os.path import join, expanduser",
          "from backfolio.datacenter import CryptocurrencyDatacenter as CryptoDC",
          "dc = CryptoDC('binance', timeframe='1h', to_sym='USDT')",
          'dc.reset(root_dir=join(expanduser("~"), ".backfolio"))',
          "dc.reload_history(refresh=True)"
        ],
      },
    ],
  };
  snippets_menu.options['menus'] = snippets_menu.default_menus;
  snippets_menu.options['menus'][0]['sub-menu'].push(horizontal_line);
  snippets_menu.options['menus'][0]['sub-menu'].push(my_favorites);
  console.log('Loaded `snippets_menu` customizations from `custom.js`');
});
