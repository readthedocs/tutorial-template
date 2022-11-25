// Add cookieyes script
var script = document.createElement("script");
script.id = "cookieyes";
script.src = "https://cdn-cookieyes.com/client_data/58bb4c6a9878d62a6e5f8065/script.js";
document.head.appendChild(script);

// Track scrolling to h2 sections by id
(function () {
  const observerCallback = (entries, observer, h2) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        // Get parent <section> of the h2, which has an id we can use to track
        var id = h2.closest("section").getAttribute("id");
        if (id && gtag) {
          console.log(id);
          gtag("event", "docs_section_view", {
            "section": id
          });
        }
      }
    });
  };

  var article = document.querySelector("div[role=main]");
  article.querySelectorAll("h2").forEach((h2) => {
    if (h2) {
      const observer = new IntersectionObserver(
        (entries) => {
          observerCallback(entries, observer, h2);
        },
        { threshold: 1 }
      );
      observer.observe(h2);
    }
  });
})();
