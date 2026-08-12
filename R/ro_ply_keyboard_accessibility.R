#' Improve keyboard accessibility for ggplotly and plotly horizontal barcharts
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Enhances the accessibility of interactive horizontal bar charts created with \code{plotly} or \code{ggplotly}.
#' This function injects custom JavaScript to make bar elements focusable and navigable via keyboard,
#' displays accessible tooltips, and ensures screen readers can interpret the chart. The function is
#' intended for use on \code{plotly} horizontal bar charts (including those created with \code{ggplotly}).
#'
#' Keyboard navigation: users can use Tab to focus the first bar, and arrow keys (Up/Down)
#' to move between bars. Pressing Esc removes focus from the chart and returns focus
#' to the next logical element.
#'
#' @param fig A \code{plotly} object representing a horizontal bar chart, such as one created by
#'  \code{plotly::plot_ly()} or \code{plotly::ggplotly()}.
#' @family plotly
#' @family ggplotly
#' @return A \code{plotly} object with improved accessibility features for keyboard and screen reader users.
#' @seealso \code{\link{ro_ply_keyboard_nav_bargraph}}
#' @export
#'
#' @examples
#' \dontrun{
#' # Example data
#' data <- tidyr::tibble(
#'   expand.grid(`Age group` = c("A", "B", "C", "D", "E"),
#'            `Sex` = c("Man", "Vrouw")
#'            ),
#'   `Number of Cases` = sample(1:50, 10, TRUE)
#' )
#'
#' # Basic ggplotly example
#' library(ggplot2)
#' library(plotly)
#' p <- ggplot(data, aes(
#'   x = `Number of Cases`,
#'   y = `Age group`,
#'   fill = Sex,
#'   text = paste0(
#'     "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
#'     "Geslacht: <b>", Sex, "</b><br>",
#'     "Aantal cases: <b>", `Number of Cases`, "</b>"
#'   )
#' )) +
#'   geom_col(position = "dodge") +
#'   labs(
#'     x = "Aantal cases",
#'     y = "Leeftijdsgroep",
#'     fill = "Geslacht"
#'   ) +
#'   theme_minimal()
#'
#' # Convert to plotly and add accessibility
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_barchart(fig)
#' fig
#'
#' # Basic plotly example
#' library(plotly)
#' fig <- plot_ly() |>
#'   add_trace(
#'     data = data,
#'     x = ~`Number of Cases`,
#'     y = ~`Age group`,
#'     color = ~`Sex`,
#'     type = "bar",
#'     orientation = "h",
#'     hovertext  = ~paste0(
#'       "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
#'       "Geslacht: <b>", `Sex`, "</b><br>",
#'       "Aantal cases: <b>", `Number of Cases`, "</b>"
#'     ),
#'     text  = ~paste0(
#'       "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
#'       "Geslacht: <b>", `Sex`, "</b><br>",
#'       "Aantal cases: <b>", `Number of Cases`, "</b>"
#'     ),
#'     textposition = "none",
#'     hoverinfo = "text"
#'   )
#' fig <- ro_ply_keyboard_nav_barchart(fig)
#' fig
#' }
ro_ply_keyboard_nav_barchart <- function(fig) {
  # Add a java-script so that the tooltip is accessible with the keyboard
  fig2 <- onRender(
    fig,
    "
   function(el, x) {
     // Helper to hide Plotly hover label
     function hidePlotlyHoverlabel() {
       if (!document.getElementById('plotly-hide-hoverlabel-style-temp')) {
         var style = document.createElement('style');
         style.id = 'plotly-hide-hoverlabel-style-temp';
         style.innerHTML = '.hoverlayer .hovertext { display: none !important; }';
         document.head.appendChild(style);
       }
     }
     // Helper function to show hoverlabel again/tooltip
     function showPlotlyHoverlabel() {
       var style = document.getElementById('plotly-hide-hoverlabel-style-temp');
       if (style) {
         style.parentNode.removeChild(style);
       }
     }
     // Create a div for the custom tooltip if not already present
     if (!document.getElementById('custom-plotly-tooltip')) {
       var tooltip = document.createElement('div');
       tooltip.id = 'custom-plotly-tooltip';
       tooltip.style.position = 'fixed';
       tooltip.style.lineHeight = '1.3'; // Space between lines similar between
       tooltip.style.pointerEvents = 'none'; // Doesn't interfer with the mouse tooltip
       tooltip.style.zIndex = 99999; // Tooltip is on top
       tooltip.style.display = 'none'; // Hidden by default
       tooltip.style.padding = '1px 2px'; // Padding similar to the mouse tool-tip
       // RIVM huisstijl
       tooltip.style.background = '#ffffff';
       tooltip.style.color = '#000000';
       tooltip.style.borderRadius = '0';
       tooltip.style.fontSize = '13px';
       tooltip.style.fontFamily = 'Arial, sans-serif';
       tooltip.style.fontStyle = 'normal';
       tooltip.style.fontWeight = 'normal';
       tooltip.style.textAlign = 'left';
       tooltip.style.border = '1px solid #000000';
       tooltip.style.boxShadow = 'none';
       document.body.appendChild(tooltip); // Add the tooltip to the page
     }
     var tooltip = document.getElementById('custom-plotly-tooltip');

     // Hide the keyboard tooltip if the mouse tooltip is used
     function hideTooltip() {
       tooltip.style.display = 'none';
     }
     document.addEventListener('mousedown', hideTooltip);
     el.on('plotly_hover', hideTooltip);

     // Function to add to each bar, regardless of filtering, that it can be accessed with the keyboard
     function addBarAccessibility() {
       // Look for all traces within the barchart
       var traces = el.querySelectorAll('.barlayer .trace');
       // Build a flat list of all bars (for arrow navigation)
       var allBars = [];
       traces.forEach(function(trace) {
         // Look for the index, corresponding to the name of the trace
         var traceName = trace.getAttribute('data-name');
         var dataIdx = -1;
         if (traceName && x && x.data) {
           for (var di = 0; di < x.data.length; di++) {
             if (x.data[di].name == traceName) {
               dataIdx = di;
               break;
             }
           }
         }
         // Make a list of traces which are found, and thus visible and not filtered
         if (dataIdx === -1 && x && x.data) {
           var visibleDataIdx = [];
           for (var i = 0; i < x.data.length; i++) {
             if (x.data[i].visible === undefined || x.data[i].visible === true) {
               visibleDataIdx.push(i);
             }
           }
           // Look for the index-positions for the traces which are visible
           var domTraces = Array.prototype.slice.call(el.querySelectorAll('.barlayer .trace'));
           var domIdx = domTraces.indexOf(trace);
           if (domIdx > -1 && domIdx < visibleDataIdx.length) {
             dataIdx = visibleDataIdx[domIdx];
           }
         }
         // Now for the bars
         var barRects = trace.querySelectorAll('.point');
         barRects.forEach(function(bar, i) {
           // Add the correct text, depending on the visible bars (with visibleindex above)
           var textContent = null;
           if (dataIdx > -1 && x.data[dataIdx] && x.data[dataIdx].text) {
             var textArray = x.data[dataIdx].text;
             if (Array.isArray(textArray)) {
               textContent = textArray[i];
             } else {
               textContent = textArray;
             }
           }
           // Add text, if it is there
           if (textContent) {
             bar.setAttribute('data-text', textContent);
           } else {
             bar.removeAttribute('data-text');
           }
           // Push all bars to the flat array for arrow navigation
           allBars.push(bar);
         });
       });

       // Accessibility: Only the first bar is tabbable, others are only focusable by arrow keys
       allBars.forEach(function(bar, idx) {
         if (idx === 0) {
           bar.setAttribute('tabindex', '0'); // Only first bar is tabbable
         } else {
           bar.setAttribute('tabindex', '-1'); // Others are not tabbable, but can be focused programmatically
         }
         // Add Aria-labels for accessibility
         bar.setAttribute('role', 'img');
         // Get the label from data-text and clean up label for screen readers
         var label = bar.getAttribute('data-text');
         if (label) {
           // Replace the linebreaks with . so that the screenreader sees it as a new sentence
           var cleanLabel = label.replace(/<br>/g, '. ');
           bar.setAttribute('aria-label', cleanLabel);
         } else {
           bar.setAttribute('aria-label', 'Bar');
         }

         bar.onfocus = function(e) {
           var rect = bar.getBoundingClientRect(); // Get the position of the bar
           var content = bar.getAttribute('data-text'); // Get the text of the content
           tooltip.innerHTML = content || ''; // Display the content
           tooltip.style.left = (rect.right + 10) + 'px'; // set the position of the tooltip
           tooltip.style.top = (rect.top - 5) + 'px';
           tooltip.style.display = content ? 'block' : 'none';

           // Show crosshair/spike
           hidePlotlyHoverlabel(); // Without tooltip label
           // Find dataIdx and i for this bar
           var barTraceIdx = -1, barPointIdx = -1;
           for (var ti = 0; ti < traces.length; ti++) {
             var bars = traces[ti].querySelectorAll('.point');
             var found = Array.prototype.indexOf.call(bars, bar);
             if (found > -1) {
               barTraceIdx = ti;
               barPointIdx = found;
               break;
             }
           }
           if (barTraceIdx > -1 && barPointIdx > -1) {
             Plotly.Fx.hover(el, [
               { curveNumber: barTraceIdx, pointNumber: barPointIdx }
             ]);
           }
         };

         // Also show tooltip on enter/space and handle keyboard navigation
         bar.onkeydown = function(e) {
           // Arrow key navigation between bars
           if (e.key === 'ArrowUp' || e.key === 'ArrowDown') {
             var nextIdx = idx + (e.key === 'ArrowUp' ? 1 : -1);
             if (nextIdx >= 0 && nextIdx < allBars.length) {
               allBars[nextIdx].focus();
             }
             e.preventDefault();
           }
           // Show tooltip/crosshair on Enter or Space
           if (e.key === 'Enter' || e.key === ' ') {
             var rect = bar.getBoundingClientRect();
             var content = bar.getAttribute('data-text');
             tooltip.innerHTML = content || '';
             tooltip.style.left = (rect.right + 10) + 'px';
             tooltip.style.top = (rect.top - 5) + 'px';
             tooltip.style.display = content ? 'block' : 'none';
             // Show crosshair/spike
             hidePlotlyHoverlabel();
             // Find dataIdx and i for this bar
             var barTraceIdx = -1, barPointIdx = -1;
             for (var ti = 0; ti < traces.length; ti++) {
               var bars = traces[ti].querySelectorAll('.point');
               var found = Array.prototype.indexOf.call(bars, bar);
               if (found > -1) {
                 barTraceIdx = ti;
                 barPointIdx = found;
                 break;
               }
             }
             if (barTraceIdx > -1 && barPointIdx > -1) {
               Plotly.Fx.hover(el, [
                 { curveNumber: barTraceIdx, pointNumber: barPointIdx }
               ]);
             }
             e.preventDefault();
           }
           // Escape the focus on the bars/points when Esc is pressed
           if (e.key === 'Escape' || e.key === 'Esc') {
             // Remove tabindex from all bars
             allBars.forEach(function(b) { b.removeAttribute('tabindex'); });

             // Try to find the next focusable element outside the plot
             var focusableSelectors = 'a, button, input, textarea, select, details, [tabindex]:not([tabindex=\"-1\"])';
             var focusableEls = Array.prototype.slice.call(document.querySelectorAll(focusableSelectors))
             .filter(function(node) { return !node.disabled && node.offsetParent !== null && !el.contains(node); });

             // If there is something to focus on, focus on that
             if (focusableEls.length > 0) {
               focusableEls[0].focus();
               e.preventDefault();
             } else {
               // If not, then create a temporary hidden button after the plot and focus it
               var tempBtn = document.createElement('button');
               tempBtn.style.position = 'absolute';
               tempBtn.style.left = '-9999px';
               tempBtn.tabIndex = 0;
               tempBtn.setAttribute('aria-label', 'Na de plot');
               tempBtn.id = 'after-plot-focus-trap';
               // Remove the button when it loses focus
               tempBtn.onblur = function() {
                 setTimeout(function() {
                   if (tempBtn && tempBtn.parentNode) {
                     tempBtn.parentNode.removeChild(tempBtn);
                   }
                 }, 100);
               };
               // Insert after plotly container
               if (el.parentNode) {
                 el.parentNode.insertBefore(tempBtn, el.nextSibling);
               } else {
                 document.body.appendChild(tempBtn);
               }
               tempBtn.focus();
               e.preventDefault();
             }
           }
         };

         bar.onblur = function(e) {
           hideTooltip();
           showPlotlyHoverlabel(); // Restore tooltip label
           Plotly.Fx.unhover(el);
         };
       }); // end allBars.forEach
     } // end addBarAccessibility

     addBarAccessibility();

   // Restore bar tabbing only if traces are shown/hidden (e.g., legend interaction)
    if (typeof(el.on) === 'function') {
      el.on('plotly_restyle', function() {
        // Only trigger once filtering is done
        setTimeout(addBarAccessibility, 0);
      });
    }

    // If the mouse is used, and a bar is focused, blur the bar so mouse tooltip works again
    el.addEventListener('mousemove', function(e) {
      var focused = el.querySelector('.barlayer .point:focus');
      if (focused) {
        focused.blur();
      }
    });

    // Force only the first bar to be tabbable after Plotly's own accessibility logic runs
setTimeout(function() {
  allBars.forEach(function(bar, idx) {
    bar.setAttribute('tabindex', idx === 0 ? '0' : '-1');
  });
}, 10);

   }
   "
  )
  return(fig2)
}


#' Improve keyboard accessibility for (stacked) bar graphs in plotly/ggplotly
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Enhances the accessibility of interactive horizontal bar charts created with \code{plotly} or \code{ggplotly}.
#' This function injects custom JavaScript to make bar elements focusable and navigable via keyboard,
#' displays accessible tooltips, and ensures screen readers can interpret the chart. The function is
#' intended for use on \code{plotly} bar graphs (including those created with \code{ggplotly}).
#'
#' Keyboard navigation: users can use Tab to focus the first bar, and arrow keys (Up/Down/Left/Right)
#' to move between bars. Pressing Esc removes focus from the chart and returns focus
#' to the next logical element.
#'
#' This function works for:
#' \itemize{
#'   \item Standard (vertical) bar graphs
#'   \item Stacked bar graphs
#'   \item Grouped/dodged bar graphs
#'   \item Proportional stacked bar graphs (bars with proportions)
#' }
#'
#' Not suitable for: \itemize{
#'   \item Horizontal barcharts
#' }
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#' @seealso \code{\link{ro_ply_keyboard_nav_barchart}}
#' @return A \code{plotly} object with improved keyboard accessibility.
#' @family ggplotly
#' @family plotly
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(plotly)
#' data <- tidyr::tibble(
#'   Sex = factor(c("Vrouw", "Man"), levels = c("Vrouw", "Man")),
#'   n = sample(1e6:5e6, 2)
#' )
#' p <- ggplot(data, aes(x = Sex, y = n, fill = Sex,
#'                       text = paste0(
#'                         "Geslacht: <b>", Sex, "</b>",
#'                         "</b><br>Aantal cases: <b>",
#'                         format(round(n, 0),
#'                         big.mark = ".", decimal.mark = ",",
#'                         scientific = FALSE), "</b>"
#'                       ))) +
#'   geom_col(width = 0.6) +
#'   labs(x = "Geslacht", y = "Aantal cases") +
#'   theme_minimal()
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_bargraph(fig)
#' fig
#' }

ro_ply_keyboard_nav_bargraph <- function(fig) {
  fig2 <- onRender(
    fig,
    "
function(el, x) {
  // First two functions to add or remove the tooltip/hoverlabel, as the crosshair/spike also creates a tooltip
  // Helper function to hide hoverlabel/tooltip
  function hidePlotlyHoverlabel() {
    if (!document.getElementById('plotly-hide-hoverlabel-style-temp')) {
      var style = document.createElement('style');
      style.id = 'plotly-hide-hoverlabel-style-temp';
      style.innerHTML = '.hoverlayer .hovertext { display: none !important; }';
      document.head.appendChild(style);
    }
  }

  // Helper function to show hoverlabel again/tooltip
  function showPlotlyHoverlabel() {
    var style = document.getElementById('plotly-hide-hoverlabel-style-temp');
    if (style) {
      style.parentNode.removeChild(style);
    }
  }

  // Create a div for the custom tooltip if not already present
  if (!document.getElementById('custom-plotly-tooltip')) { // Check if the tooltip div is already on the page
    var tooltip = document.createElement('div'); // Make a new div
    tooltip.id = 'custom-plotly-tooltip';
    tooltip.style.position = 'fixed';
    tooltip.style.lineHeight = '1.3'; // Space between lines similar between mouse tooltip and keyboard tooltip
    tooltip.style.pointerEvents = 'none'; // Doesn't interfere with the mouse tooltip
    tooltip.style.zIndex = 99999; // Tooltip is on top
    tooltip.style.display = 'none'; // Hidden by default
    tooltip.style.padding = '1px 2px'; // Padding similar to the mouse tool-tip
    // RIVM huisstijl
    tooltip.style.background = '#ffffff';
    tooltip.style.color = '#000000';
    tooltip.style.borderRadius = '0';
    tooltip.style.fontSize = '13px';
    tooltip.style.fontFamily = 'Arial, sans-serif';
    tooltip.style.fontStyle = 'normal';
    tooltip.style.fontWeight = 'normal';
    tooltip.style.textAlign = 'left';
    tooltip.style.border = '1px solid #000000';
    tooltip.style.boxShadow = 'none';
    document.body.appendChild(tooltip); // Add the tooltip to the page
  }
  var tooltip = document.getElementById('custom-plotly-tooltip');

  // Function to hide the tool-tip
  function hideTooltip() {
    tooltip.style.display = 'none';
  }

  // Hide the keyboard tooltip if the mouse tooltip is used
  document.addEventListener('mousedown', hideTooltip);
  el.on('plotly_hover', hideTooltip);

  // Function to add to each bar, regardless of filtering, that it can be accessed with the keyboard
  function addBarAccessibility() {
    var bars = []; // Collect all bars in one array for arrow-key navigation
    // Look for all traces within the barchart, in this case Men and Women
    var traces = el.querySelectorAll('.barlayer .trace');
    // Loop over all categories/traces
    traces.forEach(function(trace) {
      // Look for the index, corresponding to the name of the trace
      var traceName = trace.getAttribute('data-name');
      var dataIdx = -1;
      if (traceName && x && x.data) {
        for (var di = 0; di < x.data.length; di++) {
          if (x.data[di].name == traceName) {
            dataIdx = di;
            break;
          }
        }
      }
       // Make a list of traces which are found, and thus visible and not filtered
      if (dataIdx === -1 && x && x.data) {
        var visibleDataIdx = [];
        for (var i = 0; i < x.data.length; i++) {
          if (x.data[i].visible === undefined || x.data[i].visible === true) {
            visibleDataIdx.push(i);
          }
        }
        // Look for the index-positions for the traces which are visible
        var domTraces = Array.prototype.slice.call(el.querySelectorAll('.barlayer .trace'));
        var domIdx = domTraces.indexOf(trace);
        if (domIdx > -1 && domIdx < visibleDataIdx.length) {
          dataIdx = visibleDataIdx[domIdx];
        }
      }
      // Now for the bars
      var barRects = trace.querySelectorAll('.point');
      barRects.forEach(function(bar, i) {
        // Add the correct text, depending on the visible bars (with visibleindex above)
        var textContent = null;
        if (dataIdx > -1 && x.data[dataIdx] && x.data[dataIdx].text) {
          var textArray = x.data[dataIdx].text;
          if (Array.isArray(textArray)) {
            textContent = textArray[i];
          } else {
            textContent = textArray;
          }
        }
        // Add text, if it is there
        if (textContent) {
          bar.setAttribute('data-text', textContent);
        } else {
          bar.removeAttribute('data-text');
        }
        // Collect all bars in a single array for arrow navigation
        bars.push(bar);
        // By default, make all bars NOT tabbable (only the first will be)
        bar.setAttribute('tabindex', -1);
        // Add Aria-labels for accessibility
        bar.setAttribute('role', 'img');
        // Get the label from data-text and clean up label for screen readers
        var label = bar.getAttribute('data-text');
        if (label) {
          // Replace the linebreaks with . so that the screenreader sees it as a new sentence
          var cleanLabel = label.replace(/<br>/g, '. ');
          bar.setAttribute('aria-label', cleanLabel);
        } else {
          bar.setAttribute('aria-label', 'Bar');
        }

        // Show tooltip on focus (tab on keyboard)
        bar.onfocus = function(e) {
          var rect = bar.getBoundingClientRect();  // Get the position of the bar
          var content = bar.getAttribute('data-text'); // Get the text of the content
          tooltip.innerHTML = content || ''; // Display the content
          tooltip.style.left = (rect.right + 10) + 'px'; // set the position of the tooltip
          tooltip.style.top = (rect.top - 5) + 'px';
          tooltip.style.display = content ? 'block' : 'none';
          // Show crosshair/spike
          hidePlotlyHoverlabel(); // Without tooltip label
          Plotly.Fx.hover(el, [
            { curveNumber: dataIdx, pointNumber: i }
          ]);
        };

        // Also show tooltip on enter/space, and enable arrow navigation
        bar.onkeydown = function(e) {
          // Enter/Space = show tooltip
          if (e.key === 'Enter' || e.key === ' ') {
            var rect = bar.getBoundingClientRect();
            var content = bar.getAttribute('data-text');
            tooltip.innerHTML = content || '';
            tooltip.style.left = (rect.right + 10) + 'px';
            tooltip.style.top = (rect.top - 5) + 'px';
            tooltip.style.display = content ? 'block' : 'none';

            // Show crosshair/spike
            hidePlotlyHoverlabel(); // Without tooltip label
            Plotly.Fx.hover(el, [
              { curveNumber: dataIdx, pointNumber: i }
            ]);
            e.preventDefault();
          }
          // Arrow key navigation (right/down/left/up)
          if (
            e.key === 'ArrowDown' || e.key === 'ArrowRight' ||
            e.key === 'ArrowUp'   || e.key === 'ArrowLeft'
          ) {
            e.preventDefault();
            // Find current position in bars array
            var idx = bars.indexOf(bar);
            var nextIdx = idx;
            if (e.key === 'ArrowUp' || e.key === 'ArrowRight') {
              nextIdx = (idx + 1) % bars.length;
            } else if (e.key === 'ArrowDown' || e.key === 'ArrowLeft') {
              nextIdx = (idx - 1 + bars.length) % bars.length;
            }
            // Move focus to the next bar
            bars[nextIdx].focus();
          }
        };

        // Hide the tooltip when no longer focused
        bar.onblur = function(e) {
          hideTooltip();
          showPlotlyHoverlabel(); // Without tooltip label
          Plotly.Fx.unhover(el);
        };
      });
    });

    // Make only the first bar tabbable
    if (bars.length > 0) {
      bars[0].setAttribute('tabindex', 0);
    }
    // All other bars: tabindex -1 (only reachable by arrow keys)
    for (var k = 1; k < bars.length; k++) {
      bars[k].setAttribute('tabindex', -1);
    }
  }

  // Apply the function above
  addBarAccessibility();

  // Trigger the function if the filtering in the legend is used, as this changes the visible bars
  if (typeof(el.on) === 'function') {
    el.on('plotly_restyle', function() {
      // Only trigger once filtering is done
      setTimeout(addBarAccessibility, 0);
    });
  }
}
"
  )

  return(fig2)
}


#' Improve keyboard accessibility for scatter-trendline plots in plotly/ggplotly
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Enhances the accessibility of interactive scatter-trendline plots created with \code{plotly} or \code{ggplotly}.
#' This function injects custom JavaScript to make bar elements focusable and navigable via keyboard,
#' displays accessible tooltips, and ensures screen readers can interpret the chart. The function is
#' intended for use on \code{plotly} scatter-trendline plots (including those created with \code{ggplotly}).
#' The focusable element are the points.
#'
#' Keyboard navigation: users can use Tab to focus the first point, and arrow keys (Left/Right/Up/Down)
#' to move between points. Pressing Esc removes focus from the chart and returns focus
#' to the next logical element.
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#'
#' @return A \code{plotly} object with improved keyboard accessibility.
#'
#' @export
#' @family ggplotly
#' @family plotly
#' @examples
#' \dontrun{
#' dates <- seq(as.Date("2021-10-04"), by = "day", length.out = 100)
#' n <- round(2500 + 700 * sin(seq_along(dates) / 25) + seq_along(dates) *
#' 3 + rnorm(length(dates), 0, 150))
#'
#' moving_average <- stats::filter(n, rep(1 / 7, 7), sides = 2)
#' text <- paste0(
#'   "Dag: <b>", format(dates, "%d-%m-%Y"), "</b><br>",
#'   "Aantal cases: <b>", format(n,
#'   big.mark = ".", decimal.mark = ",", scientific = FALSE), "</b><br>",
#'   "7-daags gemiddelde: <b>",
#'   format(round(moving_average, 0),
#'    big.mark = ".",
#'    decimal.mark = ",", scientific = FALSE), "</b>"
#' )
#' data <- tibble::tibble(
#'   Date_statistics = dates,
#'   n = n,
#'   moving_average = as.numeric(moving_average),
#'   text = text
#' )
#' library(ggplot2)
#' library(plotly)
#' p <- ggplot(data, aes(x = Date_statistics, y = n, text = text, group = 1)) +
#'   geom_line() +
#'   geom_point()
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_trendline(fig)
#' fig
#' }

ro_ply_keyboard_nav_trendline <- function(fig) {
  # Add custom Javascript to make the points and lines accessible with the keyboard
  fig2 <-
    onRender(
      fig,
      "
      // create a div for the custom tooltip if not already present
      function(el, x) {

        // check if the tooltip div is already on the page
        if (!document.getElementById('custom-plotly-tooltip')) {
          var tooltip = document.createElement('div'); // make a new div
          tooltip.id = 'custom-plotly-tooltip';
          tooltip.style.position = 'fixed';
          tooltip.style.lineHeight = '1.3'; // space between lines similar between mouse and keyboard tooltip
          tooltip.style.pointerEvents = 'none'; // doesn't interfere with the mouse tooltip
          tooltip.style.zIndex = 99999; // tooltip is on top
          tooltip.style.display = 'none'; // hidden by default
          tooltip.style.padding = '1px 2px'; // padding similar to the mouse tool-tip
          // RIVM huisstijl
          tooltip.style.background = '#ffffff';
          tooltip.style.color = '#000000';
          tooltip.style.borderRadius = '0';
          tooltip.style.fontSize = '13px';
          tooltip.style.fontFamily = 'Arial, sans-serif';
          tooltip.style.fontStyle = 'normal';
          tooltip.style.fontWeight = 'normal';
          tooltip.style.textAlign = 'left';
          tooltip.style.border = '1px solid #000000';
          tooltip.style.boxShadow = 'none';
          document.body.appendChild(tooltip); // add the tooltip to the page
        }
        var tooltip = document.getElementById('custom-plotly-tooltip');

        // function to hide the tooltip
        function hideTooltip() {
          tooltip.style.display = 'none';
        }

        // ensure clicking in plot and hovering over other point hides tooltip
        document.addEventListener('mousedown', hideTooltip);
        el.on('plotly_hover', hideTooltip);

        // function to add to each point, regardless of the filtering of the categories,
        // so that it can be accessed with the keyboard
        function addPointAccessibility() {
          // look for all traces with scatters
          var traces = el.querySelectorAll('.scatterlayer .trace');
          // gather all points for keyboard navigation
          var allPoints = [];
          traces.forEach(function(trace) {
            // look for the index, corresponding to the name of the trace
            var traceName = trace.getAttribute('data-name');
            var dataIdx = -1;
            if (traceName && x && x.data) {
              for (var di = 0; di < x.data.length; di++) {
                if (x.data[di].name == traceName) {
                  dataIdx = di;
                  break;
                }
              }
            }
            // make a list of traces which are found, and thus visible and not filtered
            if (dataIdx === -1 && x && x.data) {
              var visibleDataIdx = [];
              for (var i = 0; i < x.data.length; i++) {
                if (x.data[i].visible === undefined || x.data[i].visible === true) {
                  visibleDataIdx.push(i);
                }
              }
              // look for the index-positions for the traces which are visible
              var domTraces = Array.prototype.slice.call(el.querySelectorAll('.scatterlayer .trace'));
              var domIdx = domTraces.indexOf(trace);
              if (domIdx > -1 && domIdx < visibleDataIdx.length) {
                dataIdx = visibleDataIdx[domIdx];
              }
            }
            // for the points within a category/trace
            var pts = trace.querySelectorAll('.point');
            // Add all points for keyboard navigation
            pts.forEach(function(pt) {
              allPoints.push(pt);
            });
          });

          // Now loop again to set accessibility attributes and handlers
          allPoints.forEach(function(pt, ptIdx) {
            // Determine which trace this point belongs to
            var trace = pt.closest('.trace');
            var traceName = trace ? trace.getAttribute('data-name') : null;
            var dataIdx = -1;
            if (traceName && x && x.data) {
              for (var di = 0; di < x.data.length; di++) {
                if (x.data[di].name == traceName) {
                  dataIdx = di;
                  break;
                }
              }
            }
            // Fallback for dataIdx as above
            if (dataIdx === -1 && x && x.data) {
              var visibleDataIdx = [];
              for (var i = 0; i < x.data.length; i++) {
                if (x.data[i].visible === undefined || x.data[i].visible === true) {
                  visibleDataIdx.push(i);
                }
              }
              var domTraces = Array.prototype.slice.call(el.querySelectorAll('.scatterlayer .trace'));
              var domIdx = domTraces.indexOf(trace);
              if (domIdx > -1 && domIdx < visibleDataIdx.length) {
                dataIdx = visibleDataIdx[domIdx];
              }
            }

            // add the correct text, depending on if the point is visible
            var textContent = null;
            if (dataIdx > -1 && x.data[dataIdx] && x.data[dataIdx].text) {
              var textArray = x.data[dataIdx].text;
              if (Array.isArray(textArray)) {
                textContent = textArray[ptIdx % textArray.length];
              } else {
                textContent = textArray;
              }
            }
            // add text if it is there
            if (textContent) {
              pt.setAttribute('data-text', textContent);
            } else {
              pt.removeAttribute('data-text');
            }
            // add aria labels for accessibility
            pt.setAttribute('role', 'img');

            // Only first point tab-able, other points not
            if (allPoints.length > 0) {
              if (ptIdx === 0) {
                pt.setAttribute('tabindex', '0');
              } else {
                pt.setAttribute('tabindex', '-1');
              }
            }

            // get the label from data-text and clean up the label for screenreaders
            var label = pt.getAttribute('data-text');
            if (label) {
              // replace the linebreaks with . so that the screenreader sees it as a new sentence
              var cleanLabel = label.replace(/<br>/g, '. ');
              pt.setAttribute('aria-label', cleanLabel);
            } else {
              pt.setAttribute('aria-label', 'Datapunt');
            }

            // show the tooltip when focused with tab on the keyboard
            pt.onfocus = function(e) {
              var rect = pt.getBoundingClientRect();
              var content = pt.getAttribute('data-text');
              tooltip.innerHTML = content || '';
              tooltip.style.left = (rect.right + 10) + 'px';
              tooltip.style.top = (rect.top - 5) + 'px';
              tooltip.style.display = content ? 'block' : 'none';
            };

            // and show/hide/navigate with keyboard
            pt.onkeydown = function(e) {
              // Show the tooltip with enter or space
              if (e.key === 'Enter' || e.key === ' ') {
                var rect = pt.getBoundingClientRect();
                var content = pt.getAttribute('data-text');
                tooltip.innerHTML = content || '';
                tooltip.style.left = (rect.right + 10) + 'px';
                tooltip.style.top = (rect.top - 5) + 'px';
                tooltip.style.display = content ? 'block' : 'none';
                e.preventDefault();
              }
              // Use the arrows to navigate through the points
              if (e.key === 'ArrowRight' || e.key === 'ArrowUp') {
                if (ptIdx < allPoints.length - 1) {
                  allPoints[ptIdx + 1].focus();
                }
                e.preventDefault();
              }
              if (e.key === 'ArrowLeft' || e.key === 'ArrowDown') {
                if (ptIdx > 0) {
                  allPoints[ptIdx - 1].focus();
                }
                e.preventDefault();
              }
              // Hide the tooltip on Esc
              if (e.key === 'Escape' || e.key === 'Esc') {
                hideTooltip();
                pt.blur(); // Remove keyboard focus from this point
                e.preventDefault();
              }
            };

            // hide the tooltip when no longer focused
            pt.onblur = function(e) {
              tooltip.style.display = 'none';
            };
          });
        }

        // apply the function above
        addPointAccessibility();

        // trigger the function if filtering in the legend is used,
        // as this changes the visibility of the categories of the points
        if (typeof(el.on) === 'function') {
          el.on('plotly_restyle', function() {
            setTimeout(addPointAccessibility, 0);
          });
        }
      }
    "
    )

  return(fig2)
}


#' Improve keyboard accessibility for line charts in plotly/ggplotly
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Enhances the accessibility of interactive line charts created with \code{plotly} or \code{ggplotly}.
#' This function injects custom JavaScript to make bar elements focusable and navigable via keyboard,
#' displays accessible tooltips, and ensures screen readers can interpret the chart. The function is
#' intended for use on \code{plotly} line charts (including those created with \code{ggplotly}).
#'
#' Keyboard navigation: users can use Tab to focus the first bar, and arrow keys (Left/Right/Up/Down)
#' to move between points on the line Pressing Esc removes focus from the chart and returns focus
#' to the next logical element.
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#'
#' @return A \code{plotly} object with improved keyboard accessibility for line charts.
#' @family ggplotly
#' @family plotly
#' @export
#'
#' @examples
#' \dontrun{
#' data <- tidyr::tibble(expand.grid(Jaar = 2001:2020, Geslacht = c("Man", "Vrouw")),
#'                value = sample(1:50, 40, TRUE)) |>
#'   dplyr::bind_rows(., dplyr::summarize(., value = sum(value), .by = "Jaar") |>
#'                      dplyr::mutate(Geslacht = "Totaal")) |>
#'   dplyr::mutate(Geslacht = factor(Geslacht, levels = c("Man", "Vrouw", "Totaal")))
#' library(ggplot2)
#' library(plotly)
#' p <- ggplot(data, aes(x = Jaar, y = value, color = Geslacht, group = Geslacht,
#'                       text = paste0(
#'                           "Geslacht: <b>", Geslacht,
#'                           "</b><br>Jaar: <b>", Jaar,
#'                           "</b><br>Aantal cases: <b>", value
#'                       ))) +
#'     geom_line()
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_linechart(fig)
#' fig
#' }
ro_ply_keyboard_nav_linechart <- function(fig) {
  fig2 <- htmlwidgets::onRender(
    fig,
    "
    function(el, x) {
      // Tooltip (for keyboard, can also be used for mouse)
      if (!document.getElementById('custom-plotly-tooltip')) {
        var tooltip = document.createElement('div');
        tooltip.id = 'custom-plotly-tooltip';
        tooltip.style.position = 'fixed';
        tooltip.style.zIndex = 99999;
        tooltip.style.display = 'none';
        tooltip.style.background = '#fff';
        tooltip.style.color = '#000';
        tooltip.style.border = '1px solid #000';
        tooltip.style.fontSize = '13px';
        tooltip.style.fontFamily = 'Arial, sans-serif';
        tooltip.style.padding = '1px 2px';
        document.body.appendChild(tooltip);
      }
      var tooltip = document.getElementById('custom-plotly-tooltip');
      function hideTooltip() { tooltip.style.display = 'none'; }

      // Utility: data to SVG
      function dataToSVG(trace, pointIndex) {
        var svg = el.querySelector('svg');
        if (!svg) return null;
        var gd = el;
        var xa = gd._fullLayout.xaxis;
        var ya = gd._fullLayout.yaxis;
        var xVal = trace.x[pointIndex];
        var yVal = trace.y[pointIndex];
        var xPx = xa._offset + xa.l2p(xVal);
        var yPx = ya._offset + ya.l2p(yVal);
        return {cx: xPx, cy: yPx};
      }

      // Draw or move the highlight circle
      function addOrMoveHighlight(highlightId, trace, pointIndex, color) {
        var svg = el.querySelector('svg');
        if (!svg) return;
        var highlight = svg.querySelector('#' + highlightId);
        var coords = dataToSVG(trace, pointIndex);
        if (!coords) return;
        if (!highlight) {
          highlight = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
          highlight.setAttribute('id', highlightId);
          highlight.setAttribute('r', 5);
          highlight.setAttribute('stroke-width', 3);
          highlight.setAttribute('fill', '#ffffff');
          highlight.setAttribute('pointer-events', 'none');
          svg.appendChild(highlight);
        }
   highlight.setAttribute('cx', coords.cx);
        highlight.setAttribute('cy', coords.cy);
        highlight.setAttribute('stroke', color || '#000');
        highlight.setAttribute('stroke-width', 3);
        highlight.setAttribute('r', 5);
        highlight.style.display = '';
      }

      // Remove/hide the highlight circle
      function removeHighlight(highlightId) {
        var svg = el.querySelector('svg');
        if (!svg) return;
        var highlight = svg.querySelector('#' + highlightId);
        if (highlight) highlight.style.display = 'none';
      }

      // Show tooltip at the selected point
      function showTooltipAt(trace, index, label) {
        var svg = el.querySelector('svg');
        var coords = dataToSVG(trace, index);
        if (coords && svg) {
          var pt = svg.createSVGPoint();
          pt.x = +coords.cx;
          pt.y = +coords.cy;
          var screenCTM = svg.getScreenCTM();
          var transformed = pt.matrixTransform(screenCTM);
          tooltip.innerHTML = label;
          tooltip.style.left = (transformed.x + 12) + 'px';
          tooltip.style.top = (transformed.y - 8) + 'px';
          tooltip.style.display = 'block';
        }
      }

      // --- Plotly mouse hover events for custom focus marker ---
      el.on('plotly_hover', function(e) {
        if (!e || !e.points || !e.points.length) return;
        var pt = e.points[0];
        var trace = x.data[pt.curveNumber];
        var color = trace.line && trace.line.color ? trace.line.color : '#000';
        var highlightId = 'hover-highlight-circle-' + pt.curveNumber;
        addOrMoveHighlight(highlightId, trace, pt.pointNumber, color);

        // Optionally, show tooltip (could use pt.text if present)
        var label = pt.text || ('Year: ' + pt.x + '<br>Value: ' + pt.y);
        showTooltipAt(trace, pt.pointNumber, label);
      });

      el.on('plotly_unhover', function(e) {
        if (!e || !e.points || !e.points.length) return;
        var pt = e.points[0];
        var highlightId = 'hover-highlight-circle-' + pt.curveNumber;
        removeHighlight(highlightId);
        hideTooltip();
      });

      // --- Keyboard accessibility for lines ---
      function setupKeyboardLines() {
        var lines = el.querySelectorAll('.scatterlayer .lines');

        // Remove old keyboard highlights
        var svg = el.querySelector('svg');
        if (svg) {
          Array.from(svg.querySelectorAll(\"[id^='keyboard-highlight-circle-']\")).forEach(function(c) {
            c.parentNode.removeChild(c);
          });
        }
        if (lines.length === 0) {
          setTimeout(setupKeyboardLines, 150);
          return;
        }

        // Only use visible traces
        var visibleTraces = [];
        x.data.forEach(function(trace, idx) {
          if (trace.visible === true || typeof trace.visible === 'undefined') {
            visibleTraces.push({trace: trace, idx: idx});
          }
        });

        lines.forEach(function(line, i) {
          var traceObj = visibleTraces[i];
          if (!traceObj) return;
var trace = traceObj.trace;
          line.setAttribute('tabindex', 0);
          line.setAttribute('role', 'img');
          line.style.outline = 'none';
          line.setAttribute('aria-label', trace.name ? 'Line for ' + trace.name : 'Line ' + (i+1));
          var years = trace.x;
          var values = trace.y;
          var texts = trace.text;
          var color = trace.line && trace.line.color ? trace.line.color : '#000';
          var currentYearIndex = 0;

          // Helper to get label for tooltip
          function getLabel(idx) {
            return texts && texts[idx] ? texts[idx] :
              ('Year: ' + years[idx] + '<br>Value: ' + values[idx]);
          }

          // Keyboard focus handlers
          line.addEventListener('focus', function(e) {
            currentYearIndex = 0;
            addOrMoveHighlight('keyboard-highlight-circle-' + i, trace, currentYearIndex, color);
            showTooltipAt(trace, currentYearIndex, getLabel(currentYearIndex));
          });

          line.addEventListener('keydown', function(e) {
            if (e.key === 'ArrowRight') {
              if (currentYearIndex < years.length - 1) {
                currentYearIndex++;
                addOrMoveHighlight('keyboard-highlight-circle-' + i, trace, currentYearIndex, color);
                showTooltipAt(trace, currentYearIndex, getLabel(currentYearIndex));
              }
              e.preventDefault();
            } else if (e.key === 'ArrowLeft') {
              if (currentYearIndex > 0) {
                currentYearIndex--;
                addOrMoveHighlight('keyboard-highlight-circle-' + i, trace, currentYearIndex, color);
                showTooltipAt(trace, currentYearIndex, getLabel(currentYearIndex));
              }
              e.preventDefault();
            } else if (e.key === 'Enter' || e.key === ' ') {
              addOrMoveHighlight('keyboard-highlight-circle-' + i, trace, currentYearIndex, color);
              showTooltipAt(trace, currentYearIndex, getLabel(currentYearIndex));
              e.preventDefault();
            } else if (e.key === 'Escape') {
              hideTooltip();
              removeHighlight('keyboard-highlight-circle-' + i);
              e.preventDefault();
            }
          });

          line.addEventListener('blur', function(e) {
            hideTooltip();
            removeHighlight('keyboard-highlight-circle-' + i);
          });
        });
      }

      // Initial setup for keyboard lines
      setupKeyboardLines();

      // Reapply after filtering or redraw
      el.on('plotly_restyle', setupKeyboardLines);
      el.on('plotly_relayout', setupKeyboardLines);
      el.on('plotly_redraw', setupKeyboardLines);
    }
    "
  )
  return(fig2)
}


#' Improve keyboard accessibility for plotly legends
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Makes the legend of a \code{plotly} or \code{ggplotly} plot accessible via keyboard.
#' Users can use Tab to focus legend items and activate them with Enter or Space.
#' Focus indication is only shown when navigating with the keyboard. ARIA attributes are added for screen readers.
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#'
#' @return A \code{plotly} object with improved legend accessibility.
#'
#' @export
#' @family ggplotly
#' @family plotly
#' @examples
#' \dontrun{
#' data <- tidyr::tibble(
#'   expand.grid(`Age group` = c("A", "B", "C", "D", "E"), `Sex` = c("Man", "Vrouw")),
#'   `Number of Cases` = sample(1:50, 10, TRUE)
#' )
#' library(ggplot2)
#' library(plotly)
#' p <- ggplot(data, aes(
#'   x = `Number of Cases`,
#'   y = `Age group`,
#'   fill = Sex,
#'   text = paste0(
#'     "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
#'     "Geslacht: <b>", Sex, "</b><br>",
#'     "Aantal cases: <b>", `Number of Cases`, "</b>"
#'   )
#' )) +
#'   geom_col(position = "dodge") +
#'   labs(
#'     x = "Aantal cases",
#'     y = "Leeftijdsgroep",
#'     fill = "Geslacht"
#'   )
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_barchart(fig)
#' fig <- ro_ply_keyboard_nav_legend(fig)
#' fig
#' }
ro_ply_keyboard_nav_legend <- function(fig) {
  fig2 <- onRender(
    fig,
    "function(el, x) {

  // Track last input type: keyboard or mouse
  var keyboardMode = false;
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Tab' || e.key === 'Enter' || e.key === ' ') keyboardMode = true;
  }, true);
  document.addEventListener('mousedown', function(e) { keyboardMode = false; }, true);

  const checkLegend = () => {
    const traces = el.querySelectorAll('.traces');
    if (traces.length === 0) {
      setTimeout(checkLegend, 100);
      return;
    }
    traces.forEach(trace => {
      const label = trace.querySelector('.legendtext')?.textContent || 'Legend item';
      trace.setAttribute('tabindex', '0'); // Make the trace tab-able
      trace.setAttribute('role', 'button'); // Make the legend as a button (it is in reality a svg)
      trace.setAttribute('aria-label', label);
      const isVisible = trace.style.opacity !== '0.5'; // If pressed, opacity of 0.5
      trace.setAttribute('aria-pressed', String(isVisible));

      // Focus/outline only for keyboard
      trace.addEventListener('focus', () => {
        if (keyboardMode) {
          trace.style.outline = '2px solid #333';
        } else {
          trace.style.outline = 'none';
        }
      });
      trace.addEventListener('blur', () => { trace.style.outline = 'none'; });

      // Remove focus/outline after mouse click
      trace.addEventListener('mousedown', (e) => {
        setTimeout(() => { trace.blur(); }, 0);
      });
      // Or better, prevent it from being applied at all
      trace.addEventListener('mousedown', (e) => {
        e.preventDefault(); // Prevents focus from being applied at all
      });

      // Keyboard: keep focus after activation
      trace.addEventListener('keydown', e => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          const rect = trace.querySelector('.legendtoggle');
          if (rect) {
            rect.dispatchEvent(new MouseEvent('mousedown', { bubbles: true }));
            rect.dispatchEvent(new MouseEvent('mouseup', { bubbles: true }));
            rect.dispatchEvent(new MouseEvent('click', { bubbles: true }));
            setTimeout(() => {
              const isVisible = trace.style.opacity !== '0.5';
              trace.setAttribute('aria-pressed', String(isVisible));
              // Force focus back to the legend item (for keyboard users)
              trace.focus();
            }, 0);
          }
        }
      });
          });
        };
        checkLegend();
      }
"
  )
  return(fig2)
}


#' Disable the plotly modebar (toolbar) and legend pop-up
#'
#' `r ROvis.utils::ro_group_badge('toegankelijkheid')`
#'
#' Removes the plotly modebar (toolbar) for a cleaner look and disables the pop-up for the legend,
#' which improves accessibility for keyboard users.
#'
#' @param fig A \code{plotly} object (from \code{plotly::plot_ly()} or \code{plotly::ggplotly()}).
#'
#' @return A \code{plotly} object without the modebar and with improved legend accessibility.
#'
#' @export
#' @family ggplotly
#' @family plotly
#' @examples
#' \dontrun{
#' data <- tidyr::tibble(
#'   expand.grid(`Age group` = c("A", "B", "C", "D", "E"), `Sex` = c("Man", "Vrouw")),
#'   `Number of Cases` = sample(1:50, 10, TRUE)
#' )
#' library(ggplot2)
#' library(plotly)
#' p <- ggplot(data, aes(
#'   x = `Number of Cases`,
#'   y = `Age group`,
#'   fill = Sex,
#'   text = paste0(
#'     "Leeftijdsgroep: <b>", `Age group`, "</b><br>",
#'     "Geslacht: <b>", Sex, "</b><br>",
#'     "Aantal cases: <b>", `Number of Cases`, "</b>"
#'   )
#' )) +
#'   geom_col(position = "dodge") +
#'   labs(
#'     x = "Aantal cases",
#'     y = "Leeftijdsgroep",
#'     fill = "Geslacht"
#'   )
#' fig <- ggplotly(p, tooltip = "text")
#' fig <- ro_ply_keyboard_nav_barchart(fig)
#' fig <- ro_ply_keyboard_nav_legend(fig)
#' fig <- ro_ply_disable_toolbar(fig)
#' fig
#' }

ro_ply_disable_toolbar <- function(fig) {
  # Remove the modebar for a clean look, as it is not so accessible
  fig <- plotly::config(fig, displayModeBar = FALSE)

  # Disable the pop-up when the legend is used, as this is not accessible
  fig <- fig |> plotly::layout(legend = list(itemdoubleclick = FALSE))

  fig2 <- fig
  return(fig2)
}
