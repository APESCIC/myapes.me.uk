document.addEventListener("DOMContentLoaded", () => {
  const initializeNavigation = () => {
    const toggle = document.querySelector("[data-menu-toggle]");
    const mobileNav = document.querySelector("[data-mobile-nav]");
    const desktopNav = document.querySelector("[data-desktop-nav]");
    const headerShell = document.querySelector(".header-shell");
    const megaMenus = Array.from(document.querySelectorAll(".nav-mega"));
    const mobileSections = Array.from(document.querySelectorAll(".mobile-nav-section"));
    const desktopRootLinks = desktopNav instanceof HTMLElement
      ? Array.from(desktopNav.querySelectorAll(":scope > a"))
      : [];

    const closeMegaMenus = (exceptMenu = null) => {
      megaMenus.forEach((menu) => {
        if (menu instanceof HTMLDetailsElement && menu !== exceptMenu) {
          menu.open = false;
        }
      });
    };

    if (toggle instanceof HTMLButtonElement && mobileNav instanceof HTMLElement) {
      const closeMenu = () => {
        mobileNav.classList.remove("is-open");
        toggle.setAttribute("aria-expanded", "false");
        mobileSections.forEach((section) => {
          if (section instanceof HTMLDetailsElement) {
            section.open = false;
          }
        });
      };

      toggle.addEventListener("click", () => {
        const open = mobileNav.classList.toggle("is-open");
        toggle.setAttribute("aria-expanded", String(open));
        if (!open) {
          closeMegaMenus();
        }
      });

      mobileNav.querySelectorAll("a").forEach((link) => {
        link.addEventListener("click", closeMenu);
      });

      window.addEventListener("pageshow", closeMenu);
    }

    megaMenus.forEach((menu) => {
      if (!(menu instanceof HTMLDetailsElement)) {
        return;
      }

      const summary = menu.querySelector("summary");

      menu.addEventListener("toggle", () => {
        if (menu.open) {
          closeMegaMenus(menu);
        }
      });

      if (summary instanceof HTMLElement) {
        summary.addEventListener("click", () => {
          if (!menu.open) {
            closeMegaMenus(menu);
          }
        });
      }
    });

    desktopRootLinks.forEach((link) => {
      link.addEventListener("click", () => {
        closeMegaMenus();
      });
    });

    document.addEventListener("click", (event) => {
      if (!(event.target instanceof Node)) {
        return;
      }

      if (headerShell instanceof HTMLElement && !headerShell.contains(event.target)) {
        closeMegaMenus();
      }
    });

    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape") {
        closeMegaMenus();
      }
    });

    if (desktopNav instanceof HTMLElement && mobileNav instanceof HTMLElement) {
      const desktopLinks = Array.from(desktopNav.querySelectorAll("a")).map((link) => link.textContent?.trim()).filter(Boolean);
      const mobileLinks = Array.from(mobileNav.querySelectorAll("a")).map((link) => link.textContent?.trim()).filter(Boolean);

      desktopNav.dataset.menuItems = String(desktopLinks.length);
      mobileNav.dataset.menuItems = String(mobileLinks.length);
    }
  };

  const initializeReleaseHub = () => {
    const hub = document.querySelector("[data-release-hub]");

    if (!(hub instanceof HTMLElement)) {
      return;
    }

    const searchInput = hub.querySelector("[data-release-search]");
    const filterButtons = Array.from(hub.querySelectorAll("[data-filter]"));
    const actionButtons = Array.from(hub.querySelectorAll("[data-release-action]"));
    const releaseItems = Array.from(hub.querySelectorAll("[data-release-item]"));
    const resultsLabel = hub.querySelector("[data-release-results]");

    let activeFilter = "all";

    const getTags = (entry) => {
      const raw = entry.getAttribute("data-tags") ?? "";
      return raw
        .toLowerCase()
        .split(/[\s,]+/)
        .map((tag) => tag.trim())
        .filter(Boolean);
    };

    const entryMatchesFilter = (entry) => {
      if (activeFilter === "all") {
        return true;
      }

      if (activeFilter === "current") {
        return entry.getAttribute("data-current") === "true";
      }

      if (activeFilter === "beta") {
        const status = (entry.getAttribute("data-status") ?? "").toLowerCase();
        return status.includes("beta") || getTags(entry).includes("beta");
      }

      return getTags(entry).includes(activeFilter);
    };

    const entryMatchesSearch = (entry, query) => {
      if (!query) {
        return true;
      }

      const searchableText = [
        entry.getAttribute("data-version") ?? "",
        entry.getAttribute("data-date") ?? "",
        entry.getAttribute("data-status") ?? "",
        entry.getAttribute("data-type") ?? "",
        entry.getAttribute("data-tags") ?? "",
        entry.textContent ?? ""
      ]
        .join(" ")
        .toLowerCase();

      return searchableText.includes(query);
    };

    const renderResults = () => {
      const query = searchInput instanceof HTMLInputElement ? searchInput.value.trim().toLowerCase() : "";
      let visibleCount = 0;

      releaseItems.forEach((entry) => {
        if (!(entry instanceof HTMLElement)) {
          return;
        }

        const show = entryMatchesFilter(entry) && entryMatchesSearch(entry, query);
        entry.hidden = !show;

        if (show) {
          visibleCount += 1;
        }
      });

      if (resultsLabel instanceof HTMLElement) {
        const total = releaseItems.length;
        const filterLabel = activeFilter === "all" ? "all releases" : activeFilter;
        const queryLabel = query ? ` and search \"${query}\"` : "";
        resultsLabel.textContent = `Showing ${visibleCount} of ${total} releases for ${filterLabel}${queryLabel}.`;
      }
    };

    filterButtons.forEach((button) => {
      if (!(button instanceof HTMLButtonElement)) {
        return;
      }

      button.setAttribute("aria-pressed", button.classList.contains("is-active") ? "true" : "false");

      button.addEventListener("click", () => {
        activeFilter = button.getAttribute("data-filter") ?? "all";

        filterButtons.forEach((otherButton) => {
          if (otherButton instanceof HTMLButtonElement) {
            const isActive = otherButton === button;
            otherButton.classList.toggle("is-active", isActive);
            otherButton.setAttribute("aria-pressed", isActive ? "true" : "false");
          }
        });

        renderResults();
      });
    });

    actionButtons.forEach((button) => {
      if (!(button instanceof HTMLButtonElement)) {
        return;
      }

      button.addEventListener("click", () => {
        const action = button.getAttribute("data-release-action");
        const detailsElements = hub.querySelectorAll(".release-item details");

        if (action === "expand") {
          detailsElements.forEach((details) => {
            if (details instanceof HTMLDetailsElement) {
              details.open = true;
            }
          });
        }

        if (action === "collapse") {
          detailsElements.forEach((details) => {
            if (details instanceof HTMLDetailsElement) {
              details.open = false;
            }
          });
        }
      });
    });

    if (searchInput instanceof HTMLInputElement) {
      searchInput.addEventListener("input", () => {
        renderResults();
      });
    }

    renderResults();
  };

  const initializeProtectedEmails = () => {
    const links = Array.from(document.querySelectorAll(".js-protected-email"));

    links.forEach((link) => {
      if (!(link instanceof HTMLAnchorElement)) {
        return;
      }

      const user = (link.getAttribute("data-user") ?? "").trim();
      const domain = (link.getAttribute("data-domain") ?? "").trim();

      if (!user || !domain) {
        return;
      }

      const address = `${user}@${domain}`;
      link.href = `mailto:${address}`;
      link.rel = "nofollow";

      if (link.getAttribute("data-show-address") === "true") {
        link.textContent = address;
      }
    });
  };

  initializeNavigation();
  initializeReleaseHub();
  initializeProtectedEmails();
});
