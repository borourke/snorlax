require('projects/flo.js')

$ ->
  workflow = new flo.Workflow('flo')
  start = new flo.Start()
  workflow.addChild(start)
  workflow.import('[{"name":"hackday1","routes":[],"x":194,"y":116},{"name":"hackday2","routes":[],"x":605,"y":171}]')

  workflow.stage.on 'blank_job_added', (event) ->
    $modal = $('#add-job-modal')
    $modal.modal('show')
    job = event.job
    $jobForm = $('#add-job-modal form')
    $jobForm.on 'submit', (event) ->
      event.preventDefault()
      $form = $(event.currentTarget)
      job.updateLabel($form.find('#_job_id').val())
      $modal.modal('hide')
      $jobForm.off 'submit'

  workflow.stage.on 'new_route_added', (event) ->
    $modal = $('#new-rule-modal')
    route = event.route
    $modal.find('#rule_starting_job_id').val(route.nodeA.name)
    $modal.find('#rule_ending_job_id').val(route.nodeB.name)
    $modal.modal('show')
    $routeForm = $('#new-rule-modal form')
    $routeForm.on 'submit', (event) ->
      #event.preventDefault()
      $form = $(event.currentTarget)
      operation = $form.find('#rule_operation').val()
      if operation
        route.addGate(operation[0])
      $modal.modal('hide')
      $routeForm.off 'submit'

  $('#export_chart').on 'click', ->
    console.log workflow.export()
