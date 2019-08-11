class Admin::ArticlesController < Admin::Base
  before_action :login_required, except: [:index, :show]

  def index
    @articles = Article.order(released_at: :desc)
  end

  def show
    @article = articles.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to [:admin, @article], notice: "ニュース記事を登録しました"
    else
      render "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)
    if @article.save
      redirect_to [:admin, @article], notice: "ニュース記事を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @article = @article.find(params[:id])
    @article.destroy
    redirect_to :admin_articles
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :released_at, :no_expiration, :expired_at, :member_only)
  end
end
