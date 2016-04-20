# Class trove::logging
#
#  Trove logging configuration
#
# == parameters
#
#  [*verbose*]
#    (Optional) Should the daemons log verbose messages
#    Defaults to $::os_service_default
#
#  [*debug*]
#    (Optional) Should the daemons log debug messages
#    Defaults to $::os_service_default
#
#  [*use_syslog*]
#    (Optional) Use syslog for logging.
#    Defaults to $::os_service_default
#
#  [*use_stderr*]
#    (optional) Use stderr for logging
#    Defaults to $::os_service_default
#
#  [*log_facility*]
#    (Optional) Syslog facility to receive log lines.
#    Defaults to $::os_service_default
#
#  [*log_dir*]
#    (optional) Directory where logs should be stored.
#    If set to boolean false, it will not log to any directory.
#    Defaults to '/var/log/trove'
#
#  [*log_file*]
#    (optional) The path of file used for logging
#    If set to boolean false, it will not log to any file.
#    Defaults to $::os_service_default
#
#  [*logging_context_format_string*]
#    (optional) Format string to use for log messages with context.
#    Defaults to $::os_service_default
#    Example: '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s\
#              [%(request_id)s %(user_identity)s] %(instance)s%(message)s'
#
#  [*logging_default_format_string*]
#    (optional) Format string to use for log messages without context.
#    Defaults to $::os_service_default
#    Example: '%(asctime)s.%(msecs)03d %(process)d %(levelname)s %(name)s\
#              [-] %(instance)s%(message)s'
#
#  [*logging_debug_format_suffix*]
#    (optional) Formatted data to append to log format when level is DEBUG.
#    Defaults to $::os_service_default
#    Example: '%(funcName)s %(pathname)s:%(lineno)d'
#
#  [*logging_exception_prefix*]
#    (optional) Prefix each line of exception output with this format.
#    Defaults to $::os_service_default
#    Example: '%(asctime)s.%(msecs)03d %(process)d TRACE %(name)s %(instance)s'
#
#  [*log_config_append*]
#    The name of an additional logging configuration file.
#    Defaults to $::os_service_default
#    See https://docs.python.org/2/howto/logging.html
#
#  [*default_log_levels*]
#    (optional) Hash of logger (keys) and level (values) pairs.
#    Defaults to $::os_service_default
#    Example:
#      { 'amqp' => 'WARN', 'amqplib' => 'WARN', 'boto' => 'WARN',
#        'sqlalchemy' => 'WARN', 'suds' => 'INFO', 'iso8601' => 'WARN',
#        'requests.packages.urllib3.connectionpool' => 'WARN' }
#
#  [*publish_errors*]
#    (optional) Publish error events (boolean value).
#    Defaults to $::os_service_default
#
#  [*fatal_deprecations*]
#    (optional) Make deprecations fatal (boolean value)
#    Defaults to $::os_service_default
#
#  [*instance_format*]
#    (optional) If an instance is passed with the log message, format it
#               like this (string value).
#    Defaults to $::os_service_default
#    Example: '[instance: %(uuid)s] '
#
#  [*instance_uuid_format*]
#    (optional) If an instance UUID is passed with the log message, format
#               it like this (string value).
#    Defaults to $::os_service_default
#    Example: instance_uuid_format='[instance: %(uuid)s] '
#
#  [*log_date_format*]
#    (optional) Format string for %%(asctime)s in log records.
#    Defaults to $::os_service_default
#    Example: 'Y-%m-%d %H:%M:%S'

class trove::logging(
  $use_syslog                    = $::os_service_default,
  $use_stderr                    = $::os_service_default,
  $log_facility                  = $::os_service_default,
  $log_dir                       = '/var/log/trove',
  $log_file                      = $::os_service_default,
  $verbose                       = $::os_service_default,
  $debug                         = $::os_service_default,
  $logging_context_format_string = $::os_service_default,
  $logging_default_format_string = $::os_service_default,
  $logging_debug_format_suffix   = $::os_service_default,
  $logging_exception_prefix      = $::os_service_default,
  $log_config_append             = $::os_service_default,
  $default_log_levels            = $::os_service_default,
  $publish_errors                = $::os_service_default,
  $fatal_deprecations            = $::os_service_default,
  $instance_format               = $::os_service_default,
  $instance_uuid_format          = $::os_service_default,
  $log_date_format               = $::os_service_default,
) {

  include ::trove::deps

  # NOTE(spredzy): In order to keep backward compatibility we rely on the pick function
  # to use trove::<myparam> first then trove::logging::<myparam>.
  $use_syslog_real   = pick($::trove::api::use_syslog, $use_syslog)
  $use_stderr_real   = pick($::trove::api::use_stderr, $use_stderr)
  $log_facility_real = pick($::trove::api::log_facility, $log_facility)
  $log_dir_real      = pick($::trove::api::log_dir, $log_dir)
  $log_file_real     = pick($::trove::api::log_file, $log_file)
  $verbose_real      = pick($::trove::api::verbose, $verbose)
  $debug_real        = pick($::trove::api::debug, $debug)

  oslo::log { 'trove_config':
    debug                         => $debug_real,
    verbose                       => $verbose_real,
    use_stderr                    => $use_stderr_real,
    use_syslog                    => $use_syslog_real,
    log_dir                       => $log_dir_real,
    log_file                      => $log_file_real,
    syslog_log_facility           => $log_facility_real,
    logging_context_format_string => $logging_context_format_string,
    logging_default_format_string => $logging_default_format_string,
    logging_debug_format_suffix   => $logging_debug_format_suffix,
    logging_exception_prefix      => $logging_exception_prefix,
    log_config_append             => $log_config_append,
    default_log_levels            => $default_log_levels,
    publish_errors                => $publish_errors,
    fatal_deprecations            => $fatal_deprecations,
    instance_format               => $instance_format,
    instance_uuid_format          => $instance_uuid_format,
    log_date_format               => $log_date_format
  }
}
