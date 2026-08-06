<!DOCTYPE html>
<html>
  <head>
    <!-- Include required JS files -->
    <script
      id="MathJax-script"
      async
      src="https://cdn.jsdelivr.net/npm/mathjax@3.2.2/es5/tex-mml-chtml.js"
      integrity="sha256-MASABpB4tYktI2Oitl4t+78w/lyA+D7b/s9GEP0JOGI="
      crossorigin="anonymous"
    ></script>
    <!-- <script type="text/javascript" src="../%root_path%MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script> -->
    <link rel="Stylesheet" type="text/css" href="%root_path%%css%" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/default.min.css"
      integrity="sha512-hasIneQUHlh06VNBe7f6ZcHmeRTLIaQWFd43YriJ0UND19bvYRauxthDg8E4eVNPm9bRUhr5JGeqH7FRFXQu5g=="
      crossorigin="anonymous"
    />
    <link
      rel="alternate"
      type="application/rss+xml"
      title="RSS"
      href="%root_path%%rss%"
    />
    <title>%title%</title>
    <meta http-equiv="Content-Type" content="text/html; charset=%encoding%" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </head>
  <body>
    <a href="%root_path%index.html">Index</a> |
    <a href="%root_path%diary/diary.html">Diary</a>
    <hr>
    <div class="content">%content%</div>
    <p><small>Page created on %date%</small></p>
    <script
      type="text/javascript"
      src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"
      integrity="sha512-bgHRAiTjGrzHzLyKOnpFvaEpGzJet3z4tZnXGjpsCcqOnAH6VGUx9frc5bcIhKTVLEiCO6vEhNAgx5jtLUYrfA=="
      crossorigin="anonymous"
    ></script>
    <script type="text/javascript">
      document
        .querySelectorAll("pre")
        .forEach((block) => hljs.highlightElement(block));
    </script>
  </body>
</html>
