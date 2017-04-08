// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  plugins: [
    'hyperterm-gruvbox',
    'hyperlinks',
    'hyperline'
  ],

  localPlugins: [],

  config: {
    gruvboxTheme: {
      style: 'dark', // or 'light'
      contrast: 'hard' // or 'soft', 'hard'
    },

    hyperline: {
      plugins: [{
        name: 'hostname',
        options: {
          color: 'lightBlue'
        }
      },{
        name: 'uptime',
        options: {
          color: 'lightYellow'
        }
      },{
        name: 'cpu',
        options: {
          colors: {
            high: 'lightRed',
            moderate: 'lightYellow',
            low: 'lightGreen'
          }
        }
      },{
        name: 'network',
        options: {
          color: 'lightCyan'
        }
      },{
        name: 'battery',
        options: {
          colors: {
            fine: 'lightGreen',
            critical: 'lightRed'
          }
        }
      }]
    },

    fontSize: 18,
    fontFamily: '"M+ 1m", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    cursorShape: 'BEAM', // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorBlink: false,
    foregroundColor: '#fff',
    backgroundColor: '#000',
    borderColor: '#333',
    padding: '2px 2px 16px 2px', // custom padding

    bell: false,
    copyOnSelect: true
  }
};
