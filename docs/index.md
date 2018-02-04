---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: home
title: Ruben's Maker Log
---
<h1>/var/log</h1>
<ul class="logs">
{% for post in site.posts %}
    <li class="line">
      <a href="{{ post.url | relative_url }}">
        <span class="timestamp">{{ post.date | date: "%Y-%m-%dT%H:%M:%SZ" }}</span>
        <span class="category">{{ post.category }}</span>
        <span class="text">{{ post.title }}</span>
      </a>
    </li>
{% endfor %}
</ul>
