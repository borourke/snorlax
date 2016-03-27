joint = require('jointjs')

class Workflow
  constructor: (@$container) ->
    @graph = new joint.dia.Graph
    @paper = new joint.dia.Paper({
        el: @$container
        width: 500
        height: 500
        model: @graph
        gridSize: 1
      })
    @shape = new joint.shapes.basic.Rect({
        position: { x: 100, y: 30 }
        size: { width: 100, height: 30 }
        attrs: { rect: { fill: 'blue' }, text: { text: 'my box', fill: 'white' } }
    })
    @graph.addCells([@shape])

$ ->
  $workflow = $('#workflow-container')
  new Workflow($workflow) if $workflow.length > 0
