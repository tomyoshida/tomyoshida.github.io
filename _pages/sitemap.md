---
layout: academic
lang: en
section: utility
title: Sitemap
permalink: /sitemap/
---

{% assign languages = 'en,ja,it' | split: ',' %}
{% for language in languages %}
## {{ language }}
{% assign sections = 'home,research,publications,talks,cv' | split: ',' %}
{% for section in sections %}
- [{{ site.data.site_text[language].nav[section] }}]({% if language == "en" and section == "home" %}/{% else %}/{{ language }}/{% unless section == "home" %}{{ section }}/{% endunless %}{% endif %})
{% endfor %}
{% endfor %}
