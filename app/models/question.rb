class Question < ActiveRecord::Base
  self.primary_key  = "id"
  has_many :tags, foreign_key: :id_question

  def self.find_all(params = Hash.new())
    questions= Array.new
    search = ["reference_law LIKE ? or excerpt_law LIKE ?", "%#{params[:law]}%", "%#{params[:law].gsub('_', ' ')}%"] if !params[:law].blank?
    conditions = ((params[:tags].include?(',')) ? ["tags.tag in (?)", params[:tags].gsub('_', ' ').split(',')] : ["tags.tag = ?", "#{params[:tags].gsub('_', ' ')}"]) if !params[:tags].blank?
    Question.includes(:tags).where(conditions).where(search).limit(params[:limit]).offset(params[:offset]).references(:tags).each do |field|
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
