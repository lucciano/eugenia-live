###
  @depend ../namespace.js
###
class grumble.NodeRenderer

  constructor: (item) ->
    @item = item
    @item.bind("update", @render)
    @item.bind("destroy", @remove)

  render: =>
    console.log("rendering " + @item)
    
    old_el = @el
    
    switch @item.shape
      when "rectangle" then @el = new paper.Path.Rectangle(@item.position, new paper.Size(100, 50))
      when "circle" then @el = new paper.Path.Circle(@item.position, 50)
      when "star" then @el = new paper.Path.Star(@item.position, 5, 20, 50)

    @el.position = @item.position
    @el.spine_id = @item.id
    @el.fillColor = @item.fillColor
    @el.strokeColor = @item.strokeColor
    @el.dashArray = if @item.strokeStyle is 'solid' then [10, 0] else [10, 4]
    
    if old_el
      @el.selected = old_el.selected
      old_el.remove()
  
  remove: =>
    @el.remove()
    