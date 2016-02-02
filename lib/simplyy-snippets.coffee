SimplyySnippetsView = require './simplyy-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = SimplyySnippets =
  simplyySnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @simplyySnippetsView = new SimplyySnippetsView(state.simplyySnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @simplyySnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'simplyy-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @simplyySnippetsView.destroy()

  serialize: ->
    simplyySnippetsViewState: @simplyySnippetsView.serialize()

  toggle: ->
    console.log 'SimplyySnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
