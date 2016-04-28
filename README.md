based on - https://www.youtube.com/watch?v=PQX2fgB6y10

# infinite-sroll-example
A simple example scaffold with AJAX infinite scroll on will_paginate.

To check this example, just run these commands on your terminal:

1- bundle
2- rake db:setup
3- rails server


Step-by-step example development

01- run: rails new InfiniteScrolling
02- cd InfiniteScrolling
03- add to your Gemfile: gem 'will_paginate'
04- run: bundle install
05- run: rails g scaffold Counter iteration
06- run: rake db:migrate
07- run: rails console
08- run: 100.times {|i| Counter.create(iteration: i)}
09- run: quit
10- on the counters.coffee file on your app/assets/javascripts folder, paste the following:

  jQuery ->
    if $('.pagination').length
      $(window).scroll ->
        url = $('.pagination .next_page').attr('href')
        if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
          $('.pagination').text("Fetching more records...")
          $.getScript(url)
      $(window).scroll()

11- on your app/controllers/counters_controller.rb, under the index action, enable pagination:

  def index
    @counters = Counter.page(params[:page]).per_page(33)
  end

12- on your app/views/counters folder, create the javascript response to the index action (index.js.erb), with the following content:

    $('#counters').append('<%= j render(@counters)%>');
    <% if @counters.next_page %>
      $('.pagination').replaceWith('<%= j will_paginate(@counters) %>');
    <% else %>
      $('.pagination').remove();
    <% end %>
    <% sleep 1 %>

    the 'sleep' at the end is optional (cosmetic, for testing)

13- on your app/views/counters folder, create the partial for our counter (\_counter.html.erb), with the following content:

    <tr>
      <td><%= counter.iteration %></td>
      <td><%= link_to 'Show', counter %></td>
      <td><%= link_to 'Edit', edit_counter_path(counter) %></td>
      <td><%= link_to 'Destroy', counter, method: :delete, data: { confirm: 'Are you sure?' } %></td>
    </tr>

14- on your app/views/counters folder, edit your index.html.erb, so it looks like this:

    <p id="notice"><%= notice %></p>

    <h1>Counter</h1>
    <table>
      <thead>
        <tr>
          <th>Iteration</th>
          <th colspan="3"></th>
        </tr>
      </thead>

      <tbody id="counters">
        <%= render @counters %>
      </tbody>
    </table>

    <%= will_paginate @counters %>

    <%= link_to 'New', new_counter_path %>

15- (optional) on your config/routes.rb file, add: root 'counters#index'

16- run: rails server

17- be happy
