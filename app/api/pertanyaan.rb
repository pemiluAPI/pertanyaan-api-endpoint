module Pertanyaan
  class API < Grape::API
    prefix 'api'
    format :json

    resource :pertanyaan do
      desc "Return all data question."
      get do
        {
          results: {
            count: Question.count,
            total: Question.count,
            data: Question.all
          }
        }
      end

      desc "Return a question."
      params do
        requires :id, type: Integer, desc: "Question ID."
      end
      route_param :id do
        get do
          question = Question.find_by(id: params[:id])
          {
            results: {
              count: (question) ? 1 : 0,
              total: (question) ? 1 : 0,
              data: question
            }
          }
        end
      end
    end
  end
end