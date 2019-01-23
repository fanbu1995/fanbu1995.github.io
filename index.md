---
layout: page
title: Fan Bu
subtitle: Ph.D. student in Statistics at Duke University
use-site-title: true
bigimg:
  - "img/Grandfather_Mountain_NC_2017.png" : "Grandfather Mountain, Linville NC (2017)"
  - "img/Duke_University_2017_2.jpg" : "Duke University, Durham NC (2017)"
  - "img/Washington_Lake_Seattle.JPG" : "Lake Union, Seattle WA (2017)"
  - "img/Space_Needle_Seattle.JPG": "Space Needle, Seattle WA (2017)"
---

>"Science without religion is lame, religion without science is blind."  
>  
By Albert Einstein, **_Science and Religion_**  

# Welcome to my website!

My name is Fan Bu. I am a first-year Ph.D. student in the Department of Statistical Science, Duke University. My research interests include:

- Machine Learning
- Network Analysis
- Stochastic Modelling
- Sports Data Analytics

I also love writing, sports, and music.

Click [About Me](https://fanbuduke17.github.io/aboutme) for more details.

<div class="posts-list">
  {% for post in paginator.posts %}
  <article class="post-preview">
    <a href="{{ post.url | prepend: site.baseurl }}">
	  <h2 class="post-title">{{ post.title }}</h2>

	  {% if post.subtitle %}
	  <h3 class="post-subtitle">
	    {{ post.subtitle }}
	  </h3>
	  {% endif %}
    </a>

    <p class="post-meta">
      Posted on {{ post.date | date: "%B %-d, %Y" }}
    </p>

    <div class="post-entry-container">
      {% if post.image %}
      <div class="post-image">
        <a href="{{ post.url | prepend: site.baseurl }}">
          <img src="{{ post.image }}">
        </a>
      </div>
      {% endif %}
      <div class="post-entry">
        {{ post.excerpt | strip_html | xml_escape | truncatewords: site.excerpt_length }}
        {% assign excerpt_word_count = post.excerpt | number_of_words %}
        {% if post.content != post.excerpt or excerpt_word_count > site.excerpt_length %}
          <a href="{{ post.url | prepend: site.baseurl }}" class="post-read-more">[Read&nbsp;More]</a>
        {% endif %}
      </div>
    </div>

    {% if post.tags.size > 0 %}
    <div class="blog-tags">
      Tags:
      {% if site.link-tags %}
      {% for tag in post.tags %}
      <a href="{{ site.baseurl }}/tag/{{ tag }}">{{ tag }}</a>
      {% endfor %}
      {% else %}
        {{ post.tags | join: ", " }}
      {% endif %}
    </div>
    {% endif %}

   </article>
  {% endfor %}
</div>

{% if paginator.total_pages > 1 %}
<ul class="pager main-pager">
  {% if paginator.previous_page %}
  <li class="previous">
    <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&larr; Newer Posts</a>
  </li>
  {% endif %}
  {% if paginator.next_page %}
  <li class="next">
    <a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">Older Posts &rarr;</a>
  </li>
  {% endif %}
</ul>
{% endif %}
