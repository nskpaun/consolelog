ConsolelogView = require './consolelog-view'
{CompositeDisposable} = require 'atom'

module.exports = Consolelog =
  consolelogView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @consolelogView = new ConsolelogView(state.consolelogViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @consolelogView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'consolelog:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @consolelogView.destroy()

  serialize: ->
    consolelogViewState: @consolelogView.serialize()

  toggle: ->
    console.log 'Consolelog was toggled!'
    if editor = atom.workspace.getActiveTextEditor()
      editor.insertText('console.log(\'nspaun\' + );');
      editor.moveLeft(2);
