---
layout: home
title: Ruben's Maker Log
---
<h1>Ruben's Maker Log</h1>


<h2>ls -l /projects</h2>
<div>
<span>total {{site.projects | size }}</span>
<table class="ls">
{% assign projects = site.projects | sort: 'uid' %}
{% for project in projects  %}
  {% assign tasks = site.tasks | where: "project_uid", project.uid %}
  <tr>
    <td>{{project.uid}}</td>
    <td>{{project.date | date: "%Y-%m-%d" }}</td>
    <td>{{ tasks | where: "completed", "true" | size }}</td>
    <td>{{ tasks | size }}</td>
    <td>
      <a href="{{ project.url | relative_url }}">
        {{project.title}}
      </a>
    </td>
  </tr>
{% endfor %}
</table>
</div>

<h2>cat /var/log</h2>
<ul class="logs">
{% for post in site.posts %}
    <li class="line">

        <span class="timestamp">{{ post.date | date: "%Y-%m-%dT%H:%M:%SZ" }}</span>
        <span class="category">{{ post.category }}</span>
        <a href="{{ post.url | relative_url }}">
        {{ post.title }}
        </a>

    </li>
{% endfor %}
</ul>
