#' Theme function for plotting paper-ready figures
#' @param plot_size "small" or "large" to designate how big to make plot font and line thickness
#' @param base_family to change font family to e.g. ArialMT
#' @param base_rect_size ggplot inherited argument
#' @export
#'

faith_lab_theme <- function(plot_size = 'small', base_family = 'sans', base_rect_size = 0) {
							 if (plot_size == 'big') {
								 base_size = 24
								 base_line_size = 1.5
							 } else {
 							 	base_size =  6
 	                            base_line_size = 0.25
							 }
  half_line <- base_size / 2
  ggplot2::theme(
    line = ggplot2::element_line(colour = "black", size = base_line_size, linetype = 1, lineend = "butt"),
    rect = ggplot2::element_rect(fill = NA, colour = NA, size = base_rect_size, linetype = 0),
    text = ggplot2::element_text(family = base_family, face = "plain", colour = "black", size = base_size, lineheight = 0.9, hjust = 0.5, vjust = 0.5, angle = 0, margin = ggplot2::margin(t = 0, r = 0, b = 0, l = 0, unit = 'pt'), debug = FALSE),
    axis.line = ggplot2::element_line(color = 'black'),
    axis.line.x = NULL,
    axis.line.y = NULL,
    axis.text = ggplot2::element_text(size = ggplot2::rel(0.8), colour = "black"),
    axis.text.x = ggplot2::element_text(margin = ggplot2::margin(t = 0.8 * half_line / 2), vjust = 1),
    axis.text.x.top = ggplot2::element_text(margin = ggplot2::margin(b = 0.8 * half_line / 2), vjust = 0),
    axis.text.y = ggplot2::element_text(margin = ggplot2::margin(r = 0.8 * half_line / 2), hjust = 1),
    axis.text.y.right = ggplot2::element_text(margin = ggplot2::margin(l = 0.8 * half_line / 2), hjust = 0),
    axis.ticks = ggplot2::element_line(colour = "black"),
    axis.ticks.length = ggplot2::unit(half_line / 2, "pt"),
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = half_line), vjust = 1),
    axis.title.x.top = ggplot2::element_text(margin = ggplot2::margin(b = half_line), vjust = 0),
    axis.title.y = ggplot2::element_text(angle = 90, margin = ggplot2::margin(r = half_line), vjust = 1),
    axis.title.y.right = ggplot2::element_text(angle = -90, margin = ggplot2::margin(l = half_line), vjust = 0),
    legend.background = ggplot2::element_rect(colour = 'black', linetype = 'solid', size = 0.5),
    legend.spacing = ggplot2::unit(0.4, "cm"),
    legend.spacing.x = NULL,
    legend.spacing.y = NULL,
    legend.margin = ggplot2::margin(0.2, 0.2, 0.2, 0.2, "cm"),
    legend.key = ggplot2::element_rect(fill = NA, colour = NA),
    legend.key.size = ggplot2::unit(0.25, "cm"),
    legend.key.height = NULL,
    legend.key.width = NULL,
    legend.text = ggplot2::element_text(size = ggplot2::rel(0.8)),
    legend.text.align = NULL,
    legend.title = ggplot2::element_text(hjust = 0),
    legend.title.align = 0.5,
    legend.position = "right",
    legend.direction = NULL,
    legend.justification = "center",
    legend.box = NULL,
    legend.box.margin = ggplot2::margin(1.5, 1.5, 1.5, 1.5),
    legend.box.background = ggplot2::element_blank(),
    legend.box.spacing = ggplot2::unit(0.4, "cm"),
    panel.background = ggplot2::element_rect(fill = NA, colour = NA),
    panel.border = ggplot2::element_blank(),
    panel.grid = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.spacing = ggplot2::unit(half_line, "pt"),
    panel.spacing.x = NULL,
    panel.spacing.y = NULL,
    panel.ontop = FALSE,
    strip.background = ggplot2::element_rect(colour = NA, fill = NA),
    strip.text = ggplot2::element_text(face = 'bold', colour = "black", size = ggplot2::rel(0.8), margin = ggplot2::margin(half_line, half_line, half_line, half_line)),
    strip.text.x = NULL,
    strip.text.y = ggplot2::element_text(angle = -90),
    strip.placement = "outside",
    strip.placement.x = NULL,
    strip.placement.y = NULL,
    strip.switch.pad.grid = ggplot2::unit(0.1, "cm"),
    strip.switch.pad.wrap = ggplot2::unit(0.1, "cm"),
    plot.background = ggplot2::element_blank(), #element_rect(colour = "white")
    plot.title = ggplot2::element_text(size = ggplot2::rel(1.2), hjust = 0, vjust = 1, margin = ggplot2::margin(b = half_line * 1.2)),
    plot.subtitle = ggplot2::element_text(size = ggplot2::rel(0.9), hjust = 0, vjust = 1, margin = ggplot2::margin(b = half_line * 0.9)),
    plot.caption = ggplot2::element_text(size = ggplot2::rel(0.9), hjust = 1, vjust = 1, margin = ggplot2::margin(t = half_line * 0.9)),
    #plot.tag = ggplot2::element_text(size = ggplot2::rel(1.3), hjust = 0.5, vjust = 0.5),
    #plot.tag.position = "topleft",
    plot.margin = ggplot2::margin(half_line, half_line, half_line, half_line),
    complete = TRUE)
}

#' Theme function for plotting paper-ready figures with tilted axes
#' @param plot_size "small" or "large" to designate how big to make plot font and line thickness
#' @param base_family to change font family to e.g. ArialMT
#' @param base_rect_size ggplot inherited argument
#' @export
#'

faith_lab_theme_tilted <- function(plot_size = 'small', base_family = 'sans', base_rect_size = 0) {
							 if (plot_size == 'big') {
								 base_size = 24
								 base_line_size = 1.5
							 } else {
 							 	base_size =  6
 	                            base_line_size = 0.25
							 }

  half_line <- base_size / 2
  ggplot2::theme(
    line = ggplot2::element_line(colour = "black", size = 0.5, linetype = 1, lineend = "butt"),
    rect = ggplot2::element_rect(fill = NA, colour = NA, size = base_rect_size, linetype = 0),
    text = ggplot2::element_text(family = base_family, face = "plain", colour = "black", size = base_size, lineheight = 0.9, hjust = 0.5, vjust = 0.5, angle = 0, margin = ggplot2::margin(t = 0, r = 0, b = 0, l = 0, unit = 'pt'), debug = FALSE),
    axis.line = ggplot2::element_line(color = 'black'),
    axis.line.x = NULL,
    axis.line.y = NULL,
    axis.text = ggplot2::element_text(size = ggplot2::rel(0.8), colour = "black"),
    axis.text.x = ggplot2::element_text(margin = ggplot2::margin(t = 0.8 * half_line / 2), vjust = 1, angle = 45, hjust = 1),
    axis.text.x.top = ggplot2::element_text(margin = ggplot2::margin(b = 0.8 * half_line / 2), vjust = 0),
    axis.text.y = ggplot2::element_text(margin = ggplot2::margin(r = 0.8 * half_line / 2), hjust = 1),
    axis.text.y.right = ggplot2::element_text(margin = ggplot2::margin(l = 0.8 * half_line / 2), hjust = 0),
    axis.ticks = ggplot2::element_line(colour = "black"),
    axis.ticks.length = ggplot2::unit(half_line / 2, "pt"),
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = half_line), vjust = 1),
    axis.title.x.top = ggplot2::element_text(margin = ggplot2::margin(b = half_line), vjust = 0),
    axis.title.y = ggplot2::element_text(angle = 90, margin = ggplot2::margin(r = half_line), vjust = 1),
    axis.title.y.right = ggplot2::element_text(angle = -90, margin = ggplot2::margin(l = half_line), vjust = 0),
    legend.background = ggplot2::element_rect(colour = 'black', linetype = 'solid', size = 0.5),
    legend.spacing = ggplot2::unit(0.4, "cm"),
    legend.spacing.x = NULL,
    legend.spacing.y = NULL,
    legend.margin = ggplot2::margin(0.2, 0.2, 0.2, 0.2, "cm"),
    legend.key = ggplot2::element_rect(fill = "grey95", colour = "white"),
    legend.key.size = ggplot2::unit(0.25, "cm"),
    legend.key.height = NULL,
    legend.key.width = NULL,
    legend.text = ggplot2::element_text(size = ggplot2::rel(0.8)),
    legend.text.align = NULL,
    legend.title = ggplot2::element_text(hjust = 0),
    legend.title.align = 0.5,
    legend.position = "right",
    legend.direction = NULL,
    legend.justification = "center",
    legend.box = NULL,
    legend.box.margin = ggplot2::margin(1.5, 1.5, 1.5, 1.5),
    legend.box.background = ggplot2::element_blank(),
    legend.box.spacing = ggplot2::unit(0.4, "cm"),
    panel.background = ggplot2::element_rect(fill = NA, colour = NA),
    panel.border = ggplot2::element_blank(),
    panel.grid = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.spacing = ggplot2::unit(half_line, "pt"),
    panel.spacing.x = NULL,
    panel.spacing.y = NULL,
    panel.ontop = FALSE,
    strip.background = ggplot2::element_rect(colour = NA, fill = NA),
    strip.text = ggplot2::element_text(face = 'bold', colour = "black", size = ggplot2::rel(0.8), margin = ggplot2::margin(half_line, half_line, half_line, half_line)),
    strip.text.x = NULL,
    strip.text.y = ggplot2::element_text(angle = -90),
    strip.placement = "outside",
    strip.placement.x = NULL,
    strip.placement.y = NULL,
    strip.switch.pad.grid = ggplot2::unit(0.1, "cm"),
    strip.switch.pad.wrap = ggplot2::unit(0.1, "cm"),
    plot.background = ggplot2::element_blank(), #element_rect(colour = "white")
    plot.title = ggplot2::element_text(size = ggplot2::rel(1.2), hjust = 0, vjust = 1, margin = ggplot2::margin(b = half_line * 1.2)),
    plot.subtitle = ggplot2::element_text(size = ggplot2::rel(0.9), hjust = 0, vjust = 1, margin = ggplot2::margin(b = half_line * 0.9)),
    plot.caption = ggplot2::element_text(size = ggplot2::rel(0.9), hjust = 1, vjust = 1, margin = ggplot2::margin(t = half_line * 0.9)),
    #plot.tag = ggplot2::element_text(size = ggplot2::rel(1.3), hjust = 0.5, vjust = 0.5),
    #plot.tag.position = "topleft",
    plot.margin = ggplot2::margin(half_line, half_line, half_line, half_line),
    complete = TRUE)
}

#' Color Scheme function for plotting
#' @export
#'

EJC_colors <- rep(c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#999999", "#E69F00", "red", "blue",
                    "magenta", "purple", "cyan", "yellow", "navyblue", "tan", "seagreen", "green", "goldenrod", "antiquewhite3", "darkolivegreen",
                    "brown", "deeppink3"), 100)