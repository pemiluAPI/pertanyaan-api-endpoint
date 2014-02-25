FactoryGirl.define do
  factory :question do
    id '001'
    question 'Apakah perempuan bisa mencalonkan diri dalam pemilu?'
    answer 'Ya'
    reference_law 'UUD 1945 Pasal 27 Ayat (1)'
    excerpt_law 'Pasal 27: (1) Yang menjadi warga negara ialah orang orang bangsa Indonesia asli dan orang orang bangsa lain yang disahkan dengan undangundang sebagai warga negara.'
  end

  factory :tag do
    id_question '001'
    tag 'indonesia'
  end

  
end