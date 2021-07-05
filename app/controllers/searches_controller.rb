class SearchesController < ApplicationController
  def search
    # 検索対象：User/Book
    @model = params["model"]
    # 検索条件：完全一致/部分一致
    @method = params["method"]
    # 検索ワード：検索窓の値
    @content = params["content"]
    #serach_forに代入、@model(検索対象)、@method（検索条件）、@content(検索ワード)
    @records = search_for(@model,@method,@content)
  end

  private
  def search_for(model,method,content)
    # 検索対象：user
    if model == "user"
      # 検索条件：完全一致
      if method == "perfect"
        # name:がcontent(検索ワード)のものを取得
        User.where(name: content)
      elsif method == "partial"
        User.where("name LIKE ?","%" + content + "%")
      elsif method == "forward"
        User.where("name LIKE ?",content+"%")
      elsif method == "backward"
        User.where("name LIKE ?","%"+content)
      end

    elsif model == "book"
      if method == "perfect"
        Book.where(title: content)
      elsif method  == "partial"
        Book.where("title LIKE ?","%"+content+"%")
      elsif method == "forward"
        Book.where("title LIKE ?",content + "%")
      elsif method == "backward"
        Book.where("title LIKE ?","%" + content)
      end
    end
  end
end
