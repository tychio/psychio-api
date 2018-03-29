class CreatePntImages < ActiveRecord::Migration[5.0]
  def change
    create_table :pnt_images do |t|
      t.string :name
      t.string :chinese
      t.string :uyghur
      
      t.datetime :created_at, :null=>false, default: -> {'CURRENT_TIMESTAMP'}
    end

    PntImage.create({ :name => '015', :chinese => '气球', :uyghur => 'shar' })
    PntImage.create({ :name => '016', :chinese => '香蕉', :uyghur => 'banan' })
    PntImage.create({ :name => '027', :chinese => '自行车', :uyghur => 'wélisipit' })
    PntImage.create({ :name => '040', :chinese => '蝴蝶', :uyghur => 'képiniki' })
    PntImage.create({ :name => '044', :chinese => '蜡烛', :uyghur => 'sham' })
    PntImage.create({ :name => '105', :chinese => '眼镜', :uyghur => 'közeynek' })
    PntImage.create({ :name => '109', :chinese => '葡萄', :uyghur => 'üzüm' })
    PntImage.create({ :name => '128', :chinese => '钥匙', :uyghur => 'achquch' })
    PntImage.create({ :name => '155', :chinese => '鼻子', :uyghur => 'burun' })
    PntImage.create({ :name => '215', :chinese => '勺子', :uyghur => 'qoshuq' })
    PntImage.create({ :name => '222', :chinese => '太阳', :uyghur => 'quyash' })
  end
end
