(($) ->

  Backbone.sync = (method, model, success, error) ->
    success()

  Item = Backbone.Model.extend
    defaults :
      part1 : "hello"
      part2 : "world"


  List = Backbone.Collection.extend
    model : Item


  ItemView = Backbone.View.extend
    tagName : "li"

    events :
      "click .swap" : "swap"
      "click .delete" : "remove"

    initialize : ->
      _.bindAll @, "render", "unrender", "swap", "remove"

      @model.bind "change", @render
      @model.bind "remove", @unrender

    render : ->
      $(@el).html(
        "<span style='color:black'>\
        #{@model.get('part1')} #{@model.get('part2')}\
        </span>
        <button class='swap'>swap</button>
        <button class='delete'>delete</button>"
      )
      @

    unrender : ->
      $(@el).remove()

    swap : ->
      swapped =
        part1 : @model.get "part2"
        part2 : @model.get "part1"
      @model.set(swapped)

    remove : ->
      @model.destroy()


  ListView = Backbone.View.extend
    el : $("body")

    events :
      "click button#add" : "addItem"

    initialize : ->
      _.bindAll @, "render", "addItem", "appendItem"

      @collection = new List
      @collection.bind "add", @appendItem

      @counter = 0
      @render()

    render : ->
      $(@el).append "<button id='add'>+</button>"
      $(@el).append "<ul></ul>"

      for item in @collection.models
        @appendItem item

    addItem : ->
      @counter++
      item = new Item
      item.set
        part2 : item.get("part2") + @counter
      @collection.add item

    appendItem : (item) ->
      itemView = new ItemView
        model : item

      $("ul", @el).append itemView.render().el

  listView = new ListView
)(jQuery)
