# Steps 

- rails new mack-child-jobboard
- he did model and controller steps
- rails g scaffold Job title description:text company url
- routes: rails g scaffold Job title description:text company url
- add simple form gem
- haml gem
- bootstrap sass gem
- jquery rails gem
- faker gem
- rails generate simple_form:install --bootstrap

## adding categories

- rails g model Category name
- rails db:migrate
- rails g migration add_category_id_to_jobs category_id:integer
- rails db:migrate
- update job.rb

```
belongs_to :category
```

- update category.rb

```
has_many :jobs
```

- create 4 categories in rails c: Full Time, Part Time, Freelance, Consulting
- change jobs/form partial to haml and update code to include association

```
= simple_form_for(@job, html: { class: 'form-horizontal'}) do |f|
	= f.collection_select :category_id, Category.all, :id, :name, {prompt: "Choose a category" }, input_html: { class: "dropdown-toggle" }
	= f.input :title, label: "Job Title", input_html: { class: "form-control" }
	= f.input :description, label: "Job Description", input_html: { class: "form-control" }
	= f.input :company, label: "Your Company", input_html: { class: "form-control" }
	= f.input :url, label: "Link to Job", input_html: { class: "form-control" }
	%br/
	= f.button :submit
```

- in jobs controller, update the params

```
def job_params
  params.require(:job).permit(:title, :description, :company, :url, :category_id)
end
```

- create a new job and see if it works

## Filtering by category
- update the layouts/app with the categories

```
!!!
%html
%head
  %title Ruby on Rails Jobs
  = stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true
  = javascript_include_tag 'application', 'data-turbolinks-track' => true
  = csrf_meta_tags

%body
  %nav.navbar.navbar-default
    .container
      .navbar-brand Rails Jobs
      %ul.nav.navbar-nav
        %li= link_to "All Jobs", root_path
        - Category.all.each do |category|
          %li= link_to category.name, jobs_path(category: category.name)
      = link_to "New Job", new_job_path, class: "navbar-text navbar-right navbar-link"
  .container
    .col-md-6.col-md-offset-3
      = yield
```

- update the index in jobs controller

```
	def index
		if params[:category].blank?
			@jobs = Job.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@jobs = Job.where(category_id: @category_id).order("created_at DESC")
		end
	end
```

## The end