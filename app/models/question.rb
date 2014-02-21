class Question < ActiveRecord::Base
  self.primary_key  = "id"
  has_many :tags, foreign_key: :id_question

  def self.find_all(params = Hash.new())
    questions, conditions = Array.new, Array.new
    offset = params[:offset] || 0
    limit = params[:limit] || 25
    search = ["reference_law LIKE ? or excerpt_law LIKE ?", "%#{params[:law]}%", "%#{params[:law]}%"]
    conditions = ((params[:tags].include?(',')) ? ["tags.tag in (?)", params[:tags].split(',')] : ["tags.tag = ?", "#{params[:tags]}"]) if !params[:tags].blank?
    Question.includes(:tags).where(conditions).where(search).limit(limit).offset(offset).each do |field|
      questions << field.details
    end
    questions
  end

  def details
    {
      id: self.id,
      question: self.question,
      answer: self.answer,
      reference_law: self.reference_law,
      excerpt_law: self.excerpt_law,
      tags: self.tags.map { |tag| tag.tag }
    }
  end
  
  
end
