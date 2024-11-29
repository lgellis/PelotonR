#' Add basic augmented fields to Peloton data frame
#'
#' This function augments a data frame obtained from get_workouts_df with some time and duration information.
#' @param df Peloton data frame to process
#' @param tzone Name of time zone to convert the original UTC time from. Defaults to "America/Los_Angeles"
#' @keywords Peloton, timezone, workouts, DataFrame
#' @export
#' @examples
#' augment_peloton_df()
augment_peloton_df <- function(df, tzone = "America/Los_Angeles") {
  df |>
    mutate(
      start_time_utc = lubridate::as_datetime(workout.start_time),
      start_time = lubridate::with_tz(start_time_utc, tzone=tzone),
      month = lubridate::month(start_time, label=TRUE, abbr=TRUE),
      duration_minutes = ceiling((workout.end_time - workout.start_time)/60))
}
