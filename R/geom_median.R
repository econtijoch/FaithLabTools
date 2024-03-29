# Stat Median layer

StatMedian <- ggplot2::ggproto(
  "StatMedian",
  ggplot2::Stat,
  required_aes = c("x", "y"),


  setup_params = function(data, params) {
    params$width <- if (!is.null(params$width)) {
      params$width
    } else {
      ggplot2::resolution(data$x) * 0.75
    }

    if (is.double(data$x) &&
        !data$group[1L] != -1L && any(data$x != data$x[1L])) {
      warning("Continuous x aesthetic -- did you forget aes(group=...)?",
              call. = FALSE)
    }

    params
  },

  compute_group = function(data,
                           scales,
                           width = NULL,
                           na.rm = FALSE) {
    stats <-
      data %>% dplyr::group_by(x) %>% dplyr::summarize(
        ymedian = median(y)
      )
    n <- sum(!is.na(data$y))



    if (length(unique(data$x)) > 1)
      width <-
      diff(range(data$x)) * 0.9

    df <- as.data.frame(stats)

    df$x <-
      if (is.factor(data$x))
        data$x[1]
    else
      mean(range(data$x))
    df$width <- width
    df$relvarwidth <- sqrt(n)
    df
  }
)


#' Layer function for stat
#'
#' @param mapping mapping
#' @param data dadta
#' @param geom geom
#' @param position position
#' @param ... ...
#' @param na.rm na.rm
#' @param show.legend show.legend
#' @param inherit.aes inherit.aes
#'
#' @return plot layer
#' @export
#'

stat_median <- function(mapping = NULL,
                          data = NULL,
                          geom = "median",
                          position = "dodge",
                          ...,
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = StatMedian,
    geom = GeomMedian,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm,
                  ...)
  )
}

## Geom for median layer

GeomMedian <- ggplot2::ggproto(
  "GeomMedian",
  ggplot2::Geom,
  setup_data = function(data, params) {
    data$width <- if (!is.null(data$width)) {
      data$width
    } else if (!is.null(params$width)) {
      params$width
    } else {
      ggplot2::resolution(data$x, FALSE) * 0.9
    }

    data$xmin <-
      data$x - data$width / 6
    data$xmax <-
      data$x + data$width / 6
    data$xleft <-
      data$x - data$width / 3
    data$xright <-
      data$x + data$width / 3
    data

  },

  draw_group = function(data, panel_scales, coord) {
    common <- data.frame(
      colour = 'black',
      size = data$size,
      linetype = data$linetype,
      fill = data$fill,
      group = data$group,
      alpha = data$alpha,
      stringsAsFactors = FALSE
    )


    middle <- data.frame(
      x = data$xleft,
      xend = data$xright,
      y = data$ymedian,
      yend = data$ymedian,
      common,
      stringsAsFactors = FALSE
    )


    ggname(
      "geom_median",
      grid::grobTree(
        ggplot2::GeomSegment$draw_panel(middle, panel_scales, coord)
      )
    )
  },

  draw_key = ggplot2::draw_key_boxplot,

  default_aes = ggplot2::aes(
    weight = 1,
    colour = "black",
    size = 1,
    linetype = "solid",
    alpha = NA,
    fill = NA
  ),

  required_aes = c("x", "ymedian")
)


#' New layer function that plots both the summary statistics AND the quasirandom plot from ggbeeswarm
#'
#' @param mapping mapping
#' @param data data
#' @param position position
#' @param ... ...
#' @param point.size point.size
#' @param point.color point.color
#' @param point.shape point shape
#' @param point.stroke point stroke
#' @param line.size line.size
#' @param na.rm na.rm
#' @param show.legend show.legend
#' @param inherit.aes inherit.aes
#' @param width width
#' @param varwidth varwidth
#' @param bandwidth bandwidth
#' @param nbins nbins
#' @param method method
#' @param groupOnX grouponX
#' @param dodge.width dodge.width
#'
#' @return plot layer
#' @export
#'
geom_median <- function(mapping = NULL,
                          data = NULL,
                          position = "identity",
                          ...,
                          point.size = 1,
                          point.shape = 20,
						              point.color = NULL,
						              point.stroke = 0,
                          line.size = 1,
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE,
                          width = 0.2,
                          varwidth = FALSE,
                          bandwidth = 0.5,
                          nbins = NULL,
                          method = 'quasirandom',
                          groupOnX = TRUE,
                          dodge.width = 0) {
  quasi <-
    ggbeeswarm::position_quasirandom(
      width = width,
      varwidth = varwidth,
      bandwidth = bandwidth,
      nbins = nbins,
      method = method,
      groupOnX = groupOnX,
      dodge.width = dodge.width
    )

	#if (is.null(point.shape)) {
	#	point.shape.default = 20
	#}

  if (is.null(point.color) & point.shape == 20) {
    point_layer <- ggplot2::layer(
      data = data,
      mapping = mapping,
      stat = 'identity',
      geom = ggplot2::GeomPoint,
      position = quasi,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(size = point.size,
                    stroke = point.stroke,
                    na.rm = na.rm,
                    ...)
    )
  } else if (point.shape == 20) {
    point_layer <- ggplot2::layer(
      data = data,
      mapping = mapping,
      stat = 'identity',
      geom = ggplot2::GeomPoint,
      position = quasi,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(size = point.size,
                    stroke = point.stroke,
                    na.rm = na.rm,
					color = point.color,
                    ...)
    )
  } else if (is.null(point.color)) {
    point_layer <- ggplot2::layer(
      data = data,
      mapping = mapping,
      stat = 'identity',
      geom = ggplot2::GeomPoint,
      position = quasi,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(size = point.size,
		  			shape = point.shape,
                    stroke = point.stroke,
                    na.rm = na.rm,
                    ...)
    )
  } else {
    point_layer <- ggplot2::layer(
      data = data,
      mapping = mapping,
      stat = 'identity',
      geom = ggplot2::GeomPoint,
      position = quasi,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(size = point.size,
                    shape = point.shape,
                    stroke = point.stroke,
                    na.rm = na.rm,
                    color = point.color,
                    ...)
    )
  }

  list(
    point_layer,
    ggplot2::layer(
      data = data,
      mapping = ggplot2::aes(shape = NULL, color = NULL),
      stat = StatMedian,
      geom = GeomMedian,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
	  check.aes = FALSE,
      params = list(na.rm = na.rm,
                    size = line.size,
                    ...)
    )
  )
}
