require 'spec_helper'

describe Question do
  before (:each) do
    @question = create(:question)
    @tag = create(:tag)
  end

  it "should has_many to a tags" do
    g = Question.reflect_on_association(:tags)
    g.macro.should == :has_many
  end

  it "should return details question" do
    @question.details.should == question_details
  end

  it "should return questions" do
     create(:question, id: "002")
     Question.find_all.count == 2
  end

  def question_details
    {
      id: "001",
      question: "Apakah perempuan bisa mencalonkan diri dalam pemilu?",
      answer: "Ya",
      reference_law: "UUD 1945 Pasal 27 Ayat (1)",
      excerpt_law: "Pasal 27: (1) Yang menjadi warga negara ialah orang orang bangsa Indonesia asli dan orang orang bangsa lain yang disahkan dengan undangundang sebagai warga negara.",
      tags: ["indonesia"]
    }
  end
end
