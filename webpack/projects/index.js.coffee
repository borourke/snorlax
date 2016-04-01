require('stylesheets/projects/index.scss')
_ = require('underscore')

class ProgressUpdater
  constructor: (@$container) ->
    @buildProjectTable()


  buildProjectTable: =>
    $.ajax(
      method: 'GET'
      url: '/project_status'
      dataType: 'json'
    ).done( (json) =>
      _.each(json, (project) =>
        $project_elem = $(@compileProjectTemplate(project))
        $('#projects-list').append($project_elem)
        $('#pokeball').remove()
        _.each(project.jobs, (job) =>
          $project_elem.append(@compileJobTemplate(job))
        )
        @getJobProgress()
      )
    ).fail( ->
      console.log("Failed to load projects")
    )

  compileJobTemplate: (job) ->
    template = _.template($('#job-template').html())
    template( { job: job } )

  compileProjectTemplate: (project) ->
    template = _.template($('#project-template').html())
    template( { project: project } )

  getJobProgress: =>
    $.ajax(
      method: 'GET'
      url: '/project_status'
      dataType: 'json'
    ).done( (json) =>
      jobs = _.flatten(_.map(json, (project) =>
        project.jobs
      ), true)
      @updateProgressBars(jobs)
      setTimeout( =>
        @getJobProgress()
       , 30000)
    ).fail( ->
      console.log("Progress update failed")
    )

  updateProgressBars: (jobs) =>
    _.each(jobs, (job) =>
      selector = '#' + job.alias + '-progress-bar'
      $(selector).css('width', job.percent_complete.percent_complete + '%') if $(selector).length
    )

$ ->
  $progressUpdaters = $('#project-index-wrapper')
  if $progressUpdaters.length > 0
    require('projects/pokeball')
    new ProgressUpdater($progressUpdaters)
