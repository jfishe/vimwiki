<!DOCTYPE html>
<html>
  <head>
    <!-- Include required JS files -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
    <script
      id="MathJax-script"
      async
      src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
    ></script>
    <!-- <script type="text/javascript" src="../%root_path%MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script> -->
    <link rel="Stylesheet" type="text/css" href="%root_path%%css%" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/default.min.css"
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
    ></script>
    <script type="text/javascript">
      document
        .querySelectorAll("pre")
        .forEach((block) => hljs.highlightElement(block));
    </script>
  </body>
</html>
