require('stylesheets/projects/workflow.scss')
require('projects/flo.js')

$ ->
  workflow = new flo.Workflow('flo')
  jobA = new flo.Job('123456', 100, 200)
  jobB = new flo.Job('234567', 400, 100)
  jobC = new flo.Job('345678', 400, 300)
  jobD = new flo.Job('4567890', 600, 200)
  routeAB = new flo.Route(jobA, jobB)
  routeAC = new flo.Route(jobA, jobC)
  routeBD = new flo.Route(jobB, jobD)
  routeCD = new flo.Route(jobC, jobD)
  workflow.addNode(jobA)
  workflow.addNode(jobB)
  workflow.addNode(jobC)
  workflow.addNode(jobD)
  workflow.addRoute(routeAB)
  workflow.addRoute(routeAC)
  workflow.addRoute(routeBD)
  workflow.addRoute(routeCD)
  workflow.addGate('A', routeAB)
  workflow.addGate('B', routeAC)

  $('textarea').val workflow.export()

  $('#flo_get').on 'click', ->
    $('textarea').val workflow.export()

  $('#flo_put').on 'click', ->
    workflow.import $('textarea').val()
