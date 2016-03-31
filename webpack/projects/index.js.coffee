require('stylesheets/projects/index.scss')
_ = require('underscore')

class ProgressUpdater
  constructor: (@$container) ->
    @getJobProgress()


  updateProgressBars: (jobs) ->
    _.each(jobs, (job) ->
      selector = '#' + job[0] + '-progress-bar'
      $(selector).css('width', job[1] + '%')
    )

  getJobProgress: =>
    $.ajax(
      method: 'GET'
      url: '/project_progress'
    ).done( (json) =>
      jobs = _.flatten(_.map(json, (project) ->
        key = Object.keys(project)[0]
        _.pairs(project[key].jobs)
      ), true)
      @updateProgressBars(jobs)
      setTimeout( =>
        @getJobProgress()
       , 5000)
    ).fail( ->
      console.log("Progress update failed")
    )

$ ->
  $progressUpdaters = $('#project-index-wrapper')
  new ProgressUpdater($progressUpdaters) if $progressUpdaters.length > 0
