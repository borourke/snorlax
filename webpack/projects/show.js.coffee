require('projects/flo.js')

$ ->
  workflow = new flo.Workflow('flo')
  start = new flo.Start()
  workflow.addChild(start)

  workflow.stage.on 'blank_job_added', (event) ->
    $addJobModal = $('#add-job-modal')
    $addJobModal.modal('show')
    job = event.job
    $addJobForm = $('#add-job-modal form')
    $addJobForm.on 'submit', (event) ->
      event.preventDefault()
      $form = $(event.currentTarget)
      workflow.labelJob(job, $form.find('#_job_id').val())
      $addJobModal.modal('hide')
      $addJobForm.off 'submit'

  $('textarea').val workflow.export()

  $('#flo_get').on 'click', ->
    $('textarea').val workflow.export()

  $('#flo_put').on 'click', ->
    workflow.import $('textarea').val()
