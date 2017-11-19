class InitLanguages < ActiveRecord::Migration[5.0]
  def change
    LeapqLanguage.create({ :name => 'chinese', :display => '汉语' }) 
    LeapqLanguage.create({ :name => 'uyghur', :display => '维吾尔语' }) 
    LeapqLanguage.create({ :name => 'english', :display => '英语' }) 
    LeapqLanguage.create({ :name => 'kazakh', :display => '哈萨克语' }) 
    LeapqLanguage.create({ :name => 'turkey', :display => '土耳其语' }) 
    LeapqLanguage.create({ :name => 'japanese', :display => '日语' }) 
    LeapqLanguage.create({ :name => 'korean', :display => '韩语/朝鲜语' }) 
    LeapqLanguage.create({ :name => 'french', :display => '法语' }) 
    LeapqLanguage.create({ :name => 'german', :display => '德语' }) 
    LeapqLanguage.create({ :name => 'russian', :display => '俄语' }) 
    LeapqLanguage.create({ :name => 'spanish', :display => '西班牙语' }) 
    LeapqLanguage.create({ :name => 'arabic', :display => '阿拉伯语' }) 
    LeapqLanguage.create({ :name => 'portuguese', :display => '葡萄牙语' }) 
    LeapqLanguage.create({ :name => 'other', :display => '其他' }) 
  end
end
