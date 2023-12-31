<div class="navbar">
  <div class="logo"><a href="#">PigeonHole<a/></div>
  <ul class="links">
    <li><a href="hero">Home</a></li>
    <li><a href="about">About</a></li>
    <li><a href="hero">Services</a></li>
    <li><a href="hero">Contact</a></li>
  </ul>
<a hrefs="#" class="action_btn">Login</a>
<div class="toggle_btn">
  <i class="fa-regular fa-bars"></i>
  </div>
</div>



<div class="navbar navbar-expand-sm navbar-light navbar">
  <div class="logo d-flex p-3 justify-content-center">
    <h1>PIGEONHOLE LOGO</h1>
  </div>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <button class="btn fs-4" type="button">
      <i class="fa-solid fa-magnifying-glass"></i>
      <div class="searchbar">
        <%= form_with url: pigeons_path, method: :get, data: { turbo_frame: :results }, class: "d-flex" do %>
          <%= text_field_tag :query,
                params[:query],
                class: "form-control",
                placeholder: "Type a keyword", oninput: "this.form.requestSubmit()"
            %>
          <%# <%= submit_tag "Search", name: "", class: "btn btn-dark" %>
        <% end %>
      </div>
    </button>

    <a href="#" class="avatar justify-content-start" id="navbarDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <%= image_tag "https://kitt.lewagon.com/placeholder/users/ssaunier", class: "avatar", alt: "dropdown menu" %>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto">
        <% if user_signed_in? %>
          <li class="nav-item active">
            <%= link_to "Home", "#", class: "nav-link" %>
          </li>
          <li class="nav-item">
            <%= link_to "Messages", "#", class: "nav-link" %>
          </li>
          <li class="nav-item dropdown">
          </a>
            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
              <%= link_to "User Profile", "#", class: "dropdown-item" %>
              <%= link_to "Settings", "#", class: "dropdown-item" %>
              <%= link_to "Log out", destroy_user_session_path, data: {turbo_method: :delete}, class: "dropdown-item" %>
            </div>
          </li>
        <% else %>
          <li class="nav-item">
            <%= link_to "Login", new_user_session_path, class: "nav-link" %>
          </li>
        <% end %>
      </ul>
    </div>
  </div>
</div>


<div class="dropdown-menu">
<li><%= link_to "Home", root_path %></li>
<li><a href="Messages">Messages</a></li>
<li><a href="services">My Pigeons</a></li>
<li><a href="Categories">Categories</a></li>
</div>
