class WebhooksController < ApplicationController
  def receive_units
    p "MADE IT!!!"
    payload = JSON.parse(params["payload"])
    p payload
    unit_id = payload["data"]["snorlax_unit_id"]
    unit = Unit.find(unit_id)
    unit.update_unit_data(payload["results"])
    unit.send_to_next_jobs(payload["job_id"])
    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
end