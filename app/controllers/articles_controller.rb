class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]


  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end

    # 當 render 完成後，表單仍然可以保留送出前的結果，反之 redirect_to 則是讓瀏覽器去發出一個新的請求。
    # render plain: params[:article].inspect
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
