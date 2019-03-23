---
layout: page
title: My Blog Posts
---

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ page.date | date: "%Y-%m-%d" }}, {{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
