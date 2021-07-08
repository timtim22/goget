class JobsController < ApplicationController
  before_action :authorize_request

  def all_jobs
    @jobs = Job.all.page(params[:page]).per(10) #using gem kaminari for pagination
    render json: {
      code: 200,
      success: true,
      message: 'All jobs',
      data: @jobs
    }
  end

  def create
    @job = current_user.jobs.new(job_params)
    if @job.save
      render json: {
        code: 200,
        success: true,
        message: 'Job successfully created',
        data: @job
      }
    else
      render json: {
        code: 400,
        success: false,
        message: 'Job creation failed',
        data: @job.errors.full_messages
      }
    end
  end

  def show_job
    if Job.exists?(id: params[:job_id]) # check if the id is correct
      @job = Job.find(params[:job_id])
        render json: {
          code: 200,
          success: true,
          message: 'Job',
          data: @job
        }
    else
      render json: {
        code: 400,
        success: false,
        message: "Job does not exist with id:#{params[:job_id]}"
      }
    end
  end

  def my_jobs
    @my_jobs = current_user.jobs.page(params[:page]).per(10)
    render json: {
      code: 200,
      success: true,
      message: 'My orders',
      data: @my_jobs
    }
  end

  def available_jobs
    @available_jobs = Job.where(is_claimed: false, is_executed:false).page(params[:page]).per(10) #show jobs that are not claimed and executed
    render json: {
      code: 200,
      success: true,
      message: 'Available jobs',
      data: @available_jobs
    }
  end

  def claim_job # we can have the claim job availabe again by having a cron/background job if user doesnt execute a job after 24/48 hours. 
    if Job.exists?(id: params[:job_id]) # check if the id is correct
      @job = Job.find(params[:job_id])
      if current_user.is_gogetter == true #check if a user is gogetter
        if @job.is_claimed != true #check if job is already claimed
          if @job.is_executed != true #check if job is already executed
            @job.is_claimed = true
            @job.gogetter_id = current_user.id
            if @job.save
              render json: {
                code: 200,
                success: true,
                message: 'job successfully claimed',
                data: @job
              }
            end
          else
            render json: {
              code: 400,
              success: false,
              message: 'job is already executed/completed',
              data: @job
            }
          end
        else
          if @job.gogetter_id == current_user.id
            render json: {
              code: 400,
              success: false,
              message: 'job already claimed by you',
              data: @job
            }
          else
            render json: {
              code: 400,
              success: false,
              message: 'job already claimed by another user',
              data: @job
            }
          end
        end
      else
        render json: {
          code: 400,
          success: false,
          message: 'Poster cannot claim or execute a job. Kindly signup as a Gogetter to claim a job',
          data: nil
        }
      end
    else
      render json: {
        code: 400,
        success: false,
        message: "Job does not exist with id:#{params[:job_id]}"
      }
    end
  end

  def execute_job
    if Job.exists?(id: params[:job_id]) # check if the id is correct
      @job = Job.find(params[:job_id])
      if current_user.is_gogetter == true #check if a user is gogetter
        if @job.gogetter_id == current_user.id #check if a user is executing own claimed job
          if @job.is_claimed != false #check if job is not claimed
            if @job.is_executed != true #check if job is alrady executed.
              @job.is_executed = true
              if @job.save
                render json: {
                  code: 200,
                  success: true,
                  message: 'job successfully executed/completed',
                  data: @job
                }
              end
            else
              render json: {
                code: 400,
                success: false,
                message: 'job already executed',
                data: @job
              }
            end
          else
            render json: {
              code: 400,
              success: false,
              message: 'job need to be claimed before executing it',
              data: @job
            }
          end
        else
          render json: {
            code: 400,
            success: false,
            message: 'You cannot execute someone else claimed job',
            data: nil
          }
        end
      else
        render json: {
          code: 400,
          success: false,
          message: 'You cannot claim or execute your own job',
          data: @job
        }
      end
    else
      render json: {
        code: 400,
        success: false,
        message: "Job does not exist with id:#{params[:job_id]}"
      }
    end
  end

  private

  def job_params
    params.permit(:pickup_address, :pick_lat, :pick_lng, :drop_address, :drop_lat, :drop_lng, :is_claimed, :is_executed, :user)
  end

end
