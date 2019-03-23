---
layout: page
title: My Blog Posts
---

{% for category in site.tags %}
  <h3>{{ tag[0] }}</h3>
  <ul>
    {% for post in tag[1] %}
      <li><a href="{{ post.url }}">{{ post.date | date: "%Y-%m-%d" }}, {{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
