package base

configMap: "pgsql-conf": {
	metadata: {
		annotations: description: "Configuration for PostgreSQL"
	}
	data: "postgresql.conf": """
		# -----------------------------
		# PostgreSQL configuration file
		# -----------------------------
		#
		# This file consists of lines of the form:
		#
		#   name = value
		#
		# (The \"=\" is optional.)  Whitespace may be used.  Comments are introduced with
		# \"#\" anywhere on a line.  The complete list of parameter names and allowed
		# values can be found in the PostgreSQL documentation.
		#
		# The commented-out settings shown in this file represent the default values.
		# Re-commenting a setting is NOT sufficient to revert it to the default value;
		# you need to reload the server.
		#
		# This file is read on server startup and when the server receives a SIGHUP
		# signal.  If you edit the file on a running system, you have to SIGHUP the
		# server for the changes to take effect, run \"pg_ctl reload\", or execute
		# \"SELECT pg_reload_conf()\".  Some parameters, which are marked below,
		# require a server shutdown and restart to take effect.
		#
		# Any parameter can also be given as a command-line option to the server, e.g.,
		# \"postgres -c log_connections=on\".  Some parameters can be changed at run time
		# with the \"SET\" SQL command.
		#
		# Memory units:  kB = kilobytes        Time units:  ms  = milliseconds
		#                MB = megabytes                     s   = seconds
		#                GB = gigabytes                     min = minutes
		#                TB = terabytes                     h   = hours
		#                                                   d   = days


		#------------------------------------------------------------------------------
		# FILE LOCATIONS
		#------------------------------------------------------------------------------

		# The default values of these variables are driven from the -D command-line
		# option or PGDATA environment variable, represented here as ConfigDir.

		#data_directory = 'ConfigDir'\t\t# use data in another directory
		\t\t\t\t\t# (change requires restart)
		#hba_file = 'ConfigDir/pg_hba.conf'\t# host-based authentication file
		\t\t\t\t\t# (change requires restart)
		#ident_file = 'ConfigDir/pg_ident.conf'\t# ident configuration file
		\t\t\t\t\t# (change requires restart)

		# If external_pid_file is not explicitly set, no extra PID file is written.
		#external_pid_file = ''\t\t\t# write an extra PID file
		\t\t\t\t\t# (change requires restart)


		#------------------------------------------------------------------------------
		# CONNECTIONS AND AUTHENTICATION
		#------------------------------------------------------------------------------

		# - Connection Settings -

		listen_addresses = '*'
		\t\t\t\t\t# comma-separated list of addresses;
		\t\t\t\t\t# defaults to 'localhost'; use '*' for all
		\t\t\t\t\t# (change requires restart)
		#port = 5432\t\t\t\t# (change requires restart)
		max_connections = 100\t\t\t# (change requires restart)
		#superuser_reserved_connections = 3\t# (change requires restart)
		#unix_socket_directories = '/var/run/postgresql'\t# comma-separated list of directories
		\t\t\t\t\t# (change requires restart)
		#unix_socket_group = ''\t\t\t# (change requires restart)
		#unix_socket_permissions = 0777\t\t# begin with 0 to use octal notation
		\t\t\t\t\t# (change requires restart)
		#bonjour = off\t\t\t\t# advertise server via Bonjour
		\t\t\t\t\t# (change requires restart)
		#bonjour_name = ''\t\t\t# defaults to the computer name
		\t\t\t\t\t# (change requires restart)

		# - TCP Keepalives -
		# see \"man 7 tcp\" for details

		#tcp_keepalives_idle = 0\t\t# TCP_KEEPIDLE, in seconds;
		\t\t\t\t\t# 0 selects the system default
		#tcp_keepalives_interval = 0\t\t# TCP_KEEPINTVL, in seconds;
		\t\t\t\t\t# 0 selects the system default
		#tcp_keepalives_count = 0\t\t# TCP_KEEPCNT;
		\t\t\t\t\t# 0 selects the system default

		# - Authentication -

		#authentication_timeout = 1min\t\t# 1s-600s
		#password_encryption = md5\t\t# md5 or scram-sha-256
		#db_user_namespace = off

		# GSSAPI using Kerberos
		#krb_server_keyfile = ''
		#krb_caseins_users = off

		# - SSL -

		#ssl = off
		#ssl_ca_file = ''
		#ssl_cert_file = 'server.crt'
		#ssl_crl_file = ''
		#ssl_key_file = 'server.key'
		#ssl_ciphers = 'HIGH:MEDIUM:+3DES:!aNULL' # allowed SSL ciphers
		#ssl_prefer_server_ciphers = on
		#ssl_ecdh_curve = 'prime256v1'
		#ssl_dh_params_file = ''
		#ssl_passphrase_command = ''
		#ssl_passphrase_command_supports_reload = off


		#------------------------------------------------------------------------------
		# RESOURCE USAGE (except WAL)
		#------------------------------------------------------------------------------

		# - Memory -

		shared_buffers = 128MB\t\t\t# min 128kB
		\t\t\t\t\t# (change requires restart)
		#huge_pages = try\t\t\t# on, off, or try
		\t\t\t\t\t# (change requires restart)
		#temp_buffers = 8MB\t\t\t# min 800kB
		#max_prepared_transactions = 0\t\t# zero disables the feature
		\t\t\t\t\t# (change requires restart)
		# Caution: it is not advisable to set max_prepared_transactions nonzero unless
		# you actively intend to use prepared transactions.
		#work_mem = 4MB\t\t\t\t# min 64kB
		#maintenance_work_mem = 64MB\t\t# min 1MB
		#autovacuum_work_mem = -1\t\t# min 1MB, or -1 to use maintenance_work_mem
		#max_stack_depth = 2MB\t\t\t# min 100kB
		dynamic_shared_memory_type = posix\t# the default is the first option
		\t\t\t\t\t# supported by the operating system:
		\t\t\t\t\t#   posix
		\t\t\t\t\t#   sysv
		\t\t\t\t\t#   windows
		\t\t\t\t\t#   mmap
		\t\t\t\t\t# use none to disable dynamic shared memory
		\t\t\t\t\t# (change requires restart)

		# - Disk -

		#temp_file_limit = -1\t\t\t# limits per-process temp file space
		\t\t\t\t\t# in kB, or -1 for no limit

		# - Kernel Resources -

		#max_files_per_process = 1000\t\t# min 25
		\t\t\t\t\t# (change requires restart)

		# - Cost-Based Vacuum Delay -

		#vacuum_cost_delay = 0\t\t\t# 0-100 milliseconds
		#vacuum_cost_page_hit = 1\t\t# 0-10000 credits
		#vacuum_cost_page_miss = 10\t\t# 0-10000 credits
		#vacuum_cost_page_dirty = 20\t\t# 0-10000 credits
		#vacuum_cost_limit = 200\t\t# 1-10000 credits

		# - Background Writer -

		#bgwriter_delay = 200ms\t\t\t# 10-10000ms between rounds
		#bgwriter_lru_maxpages = 100\t\t# max buffers written/round, 0 disables
		#bgwriter_lru_multiplier = 2.0\t\t# 0-10.0 multiplier on buffers scanned/round
		#bgwriter_flush_after = 512kB\t\t# measured in pages, 0 disables

		# - Asynchronous Behavior -

		#effective_io_concurrency = 1\t\t# 1-1000; 0 disables prefetching
		#max_worker_processes = 8\t\t# (change requires restart)
		#max_parallel_maintenance_workers = 2\t# taken from max_parallel_workers
		#max_parallel_workers_per_gather = 2\t# taken from max_parallel_workers
		#parallel_leader_participation = on
		#max_parallel_workers = 8\t\t# maximum number of max_worker_processes that
		\t\t\t\t\t# can be used in parallel operations
		#old_snapshot_threshold = -1\t\t# 1min-60d; -1 disables; 0 is immediate
		\t\t\t\t\t# (change requires restart)
		#backend_flush_after = 0\t\t# measured in pages, 0 disables


		#------------------------------------------------------------------------------
		# WRITE-AHEAD LOG
		#------------------------------------------------------------------------------

		# - Settings -

		#wal_level = replica\t\t\t# minimal, replica, or logical
		\t\t\t\t\t# (change requires restart)
		#fsync = on\t\t\t\t# flush data to disk for crash safety
		\t\t\t\t\t# (turning this off can cause
		\t\t\t\t\t# unrecoverable data corruption)
		#synchronous_commit = on\t\t# synchronization level;
		\t\t\t\t\t# off, local, remote_write, remote_apply, or on
		#wal_sync_method = fsync\t\t# the default is the first option
		\t\t\t\t\t# supported by the operating system:
		\t\t\t\t\t#   open_datasync
		\t\t\t\t\t#   fdatasync (default on Linux)
		\t\t\t\t\t#   fsync
		\t\t\t\t\t#   fsync_writethrough
		\t\t\t\t\t#   open_sync
		#full_page_writes = on\t\t\t# recover from partial page writes
		#wal_compression = off\t\t\t# enable compression of full-page writes
		#wal_log_hints = off\t\t\t# also do full page writes of non-critical updates
		\t\t\t\t\t# (change requires restart)
		#wal_buffers = -1\t\t\t# min 32kB, -1 sets based on shared_buffers
		\t\t\t\t\t# (change requires restart)
		#wal_writer_delay = 200ms\t\t# 1-10000 milliseconds
		#wal_writer_flush_after = 1MB\t\t# measured in pages, 0 disables

		#commit_delay = 0\t\t\t# range 0-100000, in microseconds
		#commit_siblings = 5\t\t\t# range 1-1000

		# - Checkpoints -

		#checkpoint_timeout = 5min\t\t# range 30s-1d
		max_wal_size = 1GB
		min_wal_size = 80MB
		#checkpoint_completion_target = 0.5\t# checkpoint target duration, 0.0 - 1.0
		#checkpoint_flush_after = 256kB\t\t# measured in pages, 0 disables
		#checkpoint_warning = 30s\t\t# 0 disables

		# - Archiving -

		#archive_mode = off\t\t# enables archiving; off, on, or always
		\t\t\t\t# (change requires restart)
		#archive_command = ''\t\t# command to use to archive a logfile segment
		\t\t\t\t# placeholders: %p = path of file to archive
		\t\t\t\t#               %f = file name only
		\t\t\t\t# e.g. 'test ! -f /mnt/server/archivedir/%f && cp %p /mnt/server/archivedir/%f'
		#archive_timeout = 0\t\t# force a logfile segment switch after this
		\t\t\t\t# number of seconds; 0 disables


		#------------------------------------------------------------------------------
		# REPLICATION
		#------------------------------------------------------------------------------

		# - Sending Servers -

		# Set these on the master and on any standby that will send replication data.

		#max_wal_senders = 10\t\t# max number of walsender processes
		\t\t\t\t# (change requires restart)
		#wal_keep_segments = 0\t\t# in logfile segments; 0 disables
		#wal_sender_timeout = 60s\t# in milliseconds; 0 disables

		#max_replication_slots = 10\t# max number of replication slots
		\t\t\t\t# (change requires restart)
		#track_commit_timestamp = off\t# collect timestamp of transaction commit
		\t\t\t\t# (change requires restart)

		# - Master Server -

		# These settings are ignored on a standby server.

		#synchronous_standby_names = ''\t# standby servers that provide sync rep
		\t\t\t\t# method to choose sync standbys, number of sync standbys,
		\t\t\t\t# and comma-separated list of application_name
		\t\t\t\t# from standby(s); '*' = all
		#vacuum_defer_cleanup_age = 0\t# number of xacts by which cleanup is delayed

		# - Standby Servers -

		# These settings are ignored on a master server.

		#hot_standby = on\t\t\t# \"off\" disallows queries during recovery
		\t\t\t\t\t# (change requires restart)
		#max_standby_archive_delay = 30s\t# max delay before canceling queries
		\t\t\t\t\t# when reading WAL from archive;
		\t\t\t\t\t# -1 allows indefinite delay
		#max_standby_streaming_delay = 30s\t# max delay before canceling queries
		\t\t\t\t\t# when reading streaming WAL;
		\t\t\t\t\t# -1 allows indefinite delay
		#wal_receiver_status_interval = 10s\t# send replies at least this often
		\t\t\t\t\t# 0 disables
		#hot_standby_feedback = off\t\t# send info from standby to prevent
		\t\t\t\t\t# query conflicts
		#wal_receiver_timeout = 60s\t\t# time that receiver waits for
		\t\t\t\t\t# communication from master
		\t\t\t\t\t# in milliseconds; 0 disables
		#wal_retrieve_retry_interval = 5s\t# time to wait before retrying to
		\t\t\t\t\t# retrieve WAL after a failed attempt

		# - Subscribers -

		# These settings are ignored on a publisher.

		#max_logical_replication_workers = 4\t# taken from max_worker_processes
		\t\t\t\t\t# (change requires restart)
		#max_sync_workers_per_subscription = 2\t# taken from max_logical_replication_workers


		#------------------------------------------------------------------------------
		# QUERY TUNING
		#------------------------------------------------------------------------------

		# - Planner Method Configuration -

		#enable_bitmapscan = on
		#enable_hashagg = on
		#enable_hashjoin = on
		#enable_indexscan = on
		#enable_indexonlyscan = on
		#enable_material = on
		#enable_mergejoin = on
		#enable_nestloop = on
		#enable_parallel_append = on
		#enable_seqscan = on
		#enable_sort = on
		#enable_tidscan = on
		#enable_partitionwise_join = off
		#enable_partitionwise_aggregate = off
		#enable_parallel_hash = on
		#enable_partition_pruning = on

		# - Planner Cost Constants -

		#seq_page_cost = 1.0\t\t\t# measured on an arbitrary scale
		#random_page_cost = 4.0\t\t\t# same scale as above
		#cpu_tuple_cost = 0.01\t\t\t# same scale as above
		#cpu_index_tuple_cost = 0.005\t\t# same scale as above
		#cpu_operator_cost = 0.0025\t\t# same scale as above
		#parallel_tuple_cost = 0.1\t\t# same scale as above
		#parallel_setup_cost = 1000.0\t# same scale as above

		#jit_above_cost = 100000\t\t# perform JIT compilation if available
		\t\t\t\t\t# and query more expensive than this;
		\t\t\t\t\t# -1 disables
		#jit_inline_above_cost = 500000\t\t# inline small functions if query is
		\t\t\t\t\t# more expensive than this; -1 disables
		#jit_optimize_above_cost = 500000\t# use expensive JIT optimizations if
		\t\t\t\t\t# query is more expensive than this;
		\t\t\t\t\t# -1 disables

		#min_parallel_table_scan_size = 8MB
		#min_parallel_index_scan_size = 512kB
		#effective_cache_size = 4GB

		# - Genetic Query Optimizer -

		#geqo = on
		#geqo_threshold = 12
		#geqo_effort = 5\t\t\t# range 1-10
		#geqo_pool_size = 0\t\t\t# selects default based on effort
		#geqo_generations = 0\t\t\t# selects default based on effort
		#geqo_selection_bias = 2.0\t\t# range 1.5-2.0
		#geqo_seed = 0.0\t\t\t# range 0.0-1.0

		# - Other Planner Options -

		#default_statistics_target = 100\t# range 1-10000
		#constraint_exclusion = partition\t# on, off, or partition
		#cursor_tuple_fraction = 0.1\t\t# range 0.0-1.0
		#from_collapse_limit = 8
		#join_collapse_limit = 8\t\t# 1 disables collapsing of explicit
		\t\t\t\t\t# JOIN clauses
		#force_parallel_mode = off
		#jit = off\t\t\t\t# allow JIT compilation


		#------------------------------------------------------------------------------
		# REPORTING AND LOGGING
		#------------------------------------------------------------------------------

		# - Where to Log -

		#log_destination = 'stderr'\t\t# Valid values are combinations of
		\t\t\t\t\t# stderr, csvlog, syslog, and eventlog,
		\t\t\t\t\t# depending on platform.  csvlog
		\t\t\t\t\t# requires logging_collector to be on.

		# This is used when logging to stderr:
		#logging_collector = off\t\t# Enable capturing of stderr and csvlog
		\t\t\t\t\t# into log files. Required to be on for
		\t\t\t\t\t# csvlogs.
		\t\t\t\t\t# (change requires restart)

		# These are only used if logging_collector is on:
		#log_directory = 'log'\t\t\t# directory where log files are written,
		\t\t\t\t\t# can be absolute or relative to PGDATA
		#log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'\t# log file name pattern,
		\t\t\t\t\t# can include strftime() escapes
		#log_file_mode = 0600\t\t\t# creation mode for log files,
		\t\t\t\t\t# begin with 0 to use octal notation
		#log_truncate_on_rotation = off\t\t# If on, an existing log file with the
		\t\t\t\t\t# same name as the new log file will be
		\t\t\t\t\t# truncated rather than appended to.
		\t\t\t\t\t# But such truncation only occurs on
		\t\t\t\t\t# time-driven rotation, not on restarts
		\t\t\t\t\t# or size-driven rotation.  Default is
		\t\t\t\t\t# off, meaning append to existing files
		\t\t\t\t\t# in all cases.
		#log_rotation_age = 1d\t\t\t# Automatic rotation of logfiles will
		\t\t\t\t\t# happen after that time.  0 disables.
		#log_rotation_size = 10MB\t\t# Automatic rotation of logfiles will
		\t\t\t\t\t# happen after that much log output.
		\t\t\t\t\t# 0 disables.

		# These are relevant when logging to syslog:
		#syslog_facility = 'LOCAL0'
		#syslog_ident = 'postgres'
		#syslog_sequence_numbers = on
		#syslog_split_messages = on

		# This is only relevant when logging to eventlog (win32):
		# (change requires restart)
		#event_source = 'PostgreSQL'

		# - When to Log -

		#log_min_messages = warning\t\t# values in order of decreasing detail:
		\t\t\t\t\t#   debug5
		\t\t\t\t\t#   debug4
		\t\t\t\t\t#   debug3
		\t\t\t\t\t#   debug2
		\t\t\t\t\t#   debug1
		\t\t\t\t\t#   info
		\t\t\t\t\t#   notice
		\t\t\t\t\t#   warning
		\t\t\t\t\t#   error
		\t\t\t\t\t#   log
		\t\t\t\t\t#   fatal
		\t\t\t\t\t#   panic

		#log_min_error_statement = error\t# values in order of decreasing detail:
		\t\t\t\t\t#   debug5
		\t\t\t\t\t#   debug4
		\t\t\t\t\t#   debug3
		\t\t\t\t\t#   debug2
		\t\t\t\t\t#   debug1
		\t\t\t\t\t#   info
		\t\t\t\t\t#   notice
		\t\t\t\t\t#   warning
		\t\t\t\t\t#   error
		\t\t\t\t\t#   log
		\t\t\t\t\t#   fatal
		\t\t\t\t\t#   panic (effectively off)

		#log_min_duration_statement = -1\t# -1 is disabled, 0 logs all statements
		\t\t\t\t\t# and their durations, > 0 logs only
		\t\t\t\t\t# statements running at least this number
		\t\t\t\t\t# of milliseconds


		# - What to Log -

		#debug_print_parse = off
		#debug_print_rewritten = off
		#debug_print_plan = off
		#debug_pretty_print = on
		#log_checkpoints = off
		#log_connections = off
		#log_disconnections = off
		#log_duration = off
		#log_error_verbosity = default\t\t# terse, default, or verbose messages
		#log_hostname = off
		#log_line_prefix = '%m [%p] '\t\t# special values:
		\t\t\t\t\t#   %a = application name
		\t\t\t\t\t#   %u = user name
		\t\t\t\t\t#   %d = database name
		\t\t\t\t\t#   %r = remote host and port
		\t\t\t\t\t#   %h = remote host
		\t\t\t\t\t#   %p = process ID
		\t\t\t\t\t#   %t = timestamp without milliseconds
		\t\t\t\t\t#   %m = timestamp with milliseconds
		\t\t\t\t\t#   %n = timestamp with milliseconds (as a Unix epoch)
		\t\t\t\t\t#   %i = command tag
		\t\t\t\t\t#   %e = SQL state
		\t\t\t\t\t#   %c = session ID
		\t\t\t\t\t#   %l = session line number
		\t\t\t\t\t#   %s = session start timestamp
		\t\t\t\t\t#   %v = virtual transaction ID
		\t\t\t\t\t#   %x = transaction ID (0 if none)
		\t\t\t\t\t#   %q = stop here in non-session
		\t\t\t\t\t#        processes
		\t\t\t\t\t#   %% = '%'
		\t\t\t\t\t# e.g. '<%u%%%d> '
		#log_lock_waits = off\t\t\t# log lock waits >= deadlock_timeout
		#log_statement = 'none'\t\t\t# none, ddl, mod, all
		#log_replication_commands = off
		#log_temp_files = -1\t\t\t# log temporary files equal or larger
		\t\t\t\t\t# than the specified size in kilobytes;
		\t\t\t\t\t# -1 disables, 0 logs all temp files
		log_timezone = 'Etc/UTC'

		#------------------------------------------------------------------------------
		# PROCESS TITLE
		#------------------------------------------------------------------------------

		#cluster_name = ''\t\t\t# added to process titles if nonempty
		\t\t\t\t\t# (change requires restart)
		#update_process_title = on


		#------------------------------------------------------------------------------
		# STATISTICS
		#------------------------------------------------------------------------------

		# - Query and Index Statistics Collector -

		#track_activities = on
		#track_counts = on
		#track_io_timing = off
		#track_functions = none\t\t\t# none, pl, all
		#track_activity_query_size = 1024\t# (change requires restart)
		#stats_temp_directory = 'pg_stat_tmp'


		# - Monitoring -

		#log_parser_stats = off
		#log_planner_stats = off
		#log_executor_stats = off
		#log_statement_stats = off


		#------------------------------------------------------------------------------
		# AUTOVACUUM
		#------------------------------------------------------------------------------

		#autovacuum = on\t\t\t# Enable autovacuum subprocess?  'on'
		\t\t\t\t\t# requires track_counts to also be on.
		#log_autovacuum_min_duration = -1\t# -1 disables, 0 logs all actions and
		\t\t\t\t\t# their durations, > 0 logs only
		\t\t\t\t\t# actions running at least this number
		\t\t\t\t\t# of milliseconds.
		#autovacuum_max_workers = 3\t\t# max number of autovacuum subprocesses
		\t\t\t\t\t# (change requires restart)
		#autovacuum_naptime = 1min\t\t# time between autovacuum runs
		#autovacuum_vacuum_threshold = 50\t# min number of row updates before
		\t\t\t\t\t# vacuum
		#autovacuum_analyze_threshold = 50\t# min number of row updates before
		\t\t\t\t\t# analyze
		#autovacuum_vacuum_scale_factor = 0.2\t# fraction of table size before vacuum
		#autovacuum_analyze_scale_factor = 0.1\t# fraction of table size before analyze
		#autovacuum_freeze_max_age = 200000000\t# maximum XID age before forced vacuum
		\t\t\t\t\t# (change requires restart)
		#autovacuum_multixact_freeze_max_age = 400000000\t# maximum multixact age
		\t\t\t\t\t# before forced vacuum
		\t\t\t\t\t# (change requires restart)
		#autovacuum_vacuum_cost_delay = 20ms\t# default vacuum cost delay for
		\t\t\t\t\t# autovacuum, in milliseconds;
		\t\t\t\t\t# -1 means use vacuum_cost_delay
		#autovacuum_vacuum_cost_limit = -1\t# default vacuum cost limit for
		\t\t\t\t\t# autovacuum, -1 means use
		\t\t\t\t\t# vacuum_cost_limit


		#------------------------------------------------------------------------------
		# CLIENT CONNECTION DEFAULTS
		#------------------------------------------------------------------------------

		# - Statement Behavior -

		#client_min_messages = notice\t\t# values in order of decreasing detail:
		\t\t\t\t\t#   debug5
		\t\t\t\t\t#   debug4
		\t\t\t\t\t#   debug3
		\t\t\t\t\t#   debug2
		\t\t\t\t\t#   debug1
		\t\t\t\t\t#   log
		\t\t\t\t\t#   notice
		\t\t\t\t\t#   warning
		\t\t\t\t\t#   error
		#search_path = '\"$user\", public'\t# schema names
		#row_security = on
		#default_tablespace = ''\t\t# a tablespace name, '' uses the default
		#temp_tablespaces = ''\t\t\t# a list of tablespace names, '' uses
		\t\t\t\t\t# only default tablespace
		#check_function_bodies = on
		#default_transaction_isolation = 'read committed'
		#default_transaction_read_only = off
		#default_transaction_deferrable = off
		#session_replication_role = 'origin'
		#statement_timeout = 0\t\t\t# in milliseconds, 0 is disabled
		#lock_timeout = 0\t\t\t# in milliseconds, 0 is disabled
		#idle_in_transaction_session_timeout = 0\t# in milliseconds, 0 is disabled
		#vacuum_freeze_min_age = 50000000
		#vacuum_freeze_table_age = 150000000
		#vacuum_multixact_freeze_min_age = 5000000
		#vacuum_multixact_freeze_table_age = 150000000
		#vacuum_cleanup_index_scale_factor = 0.1\t# fraction of total number of tuples
		\t\t\t\t\t\t# before index cleanup, 0 always performs
		\t\t\t\t\t\t# index cleanup
		#bytea_output = 'hex'\t\t\t# hex, escape
		#xmlbinary = 'base64'
		#xmloption = 'content'
		#gin_fuzzy_search_limit = 0
		#gin_pending_list_limit = 4MB

		# - Locale and Formatting -

		datestyle = 'iso, mdy'
		#intervalstyle = 'postgres'
		timezone = 'Etc/UTC'
		#timezone_abbreviations = 'Default'     # Select the set of available time zone
		\t\t\t\t\t# abbreviations.  Currently, there are
		\t\t\t\t\t#   Default
		\t\t\t\t\t#   Australia (historical usage)
		\t\t\t\t\t#   India
		\t\t\t\t\t# You can create your own file in
		\t\t\t\t\t# share/timezonesets/.
		#extra_float_digits = 0\t\t\t# min -15, max 3
		#client_encoding = sql_ascii\t\t# actually, defaults to database
		\t\t\t\t\t# encoding

		# These settings are initialized by initdb, but they can be changed.
		lc_messages = 'en_US.utf8'\t\t\t# locale for system error message
		\t\t\t\t\t# strings
		lc_monetary = 'en_US.utf8'\t\t\t# locale for monetary formatting
		lc_numeric = 'en_US.utf8'\t\t\t# locale for number formatting
		lc_time = 'en_US.utf8'\t\t\t\t# locale for time formatting

		# default configuration for text search
		default_text_search_config = 'pg_catalog.english'

		# - Shared Library Preloading -

		#shared_preload_libraries = ''\t# (change requires restart)
		#local_preload_libraries = ''
		#session_preload_libraries = ''
		#jit_provider = 'llvmjit'\t\t# JIT library to use

		# - Other Defaults -

		#dynamic_library_path = '$libdir'


		#------------------------------------------------------------------------------
		# LOCK MANAGEMENT
		#------------------------------------------------------------------------------

		#deadlock_timeout = 1s
		#max_locks_per_transaction = 64\t\t# min 10
		\t\t\t\t\t# (change requires restart)
		#max_pred_locks_per_transaction = 64\t# min 10
		\t\t\t\t\t# (change requires restart)
		#max_pred_locks_per_relation = -2\t# negative values mean
		\t\t\t\t\t# (max_pred_locks_per_transaction
		\t\t\t\t\t#  / -max_pred_locks_per_relation) - 1
		#max_pred_locks_per_page = 2            # min 0


		#------------------------------------------------------------------------------
		# VERSION AND PLATFORM COMPATIBILITY
		#------------------------------------------------------------------------------

		# - Previous PostgreSQL Versions -

		#array_nulls = on
		#backslash_quote = safe_encoding\t# on, off, or safe_encoding
		#default_with_oids = off
		#escape_string_warning = on
		#lo_compat_privileges = off
		#operator_precedence_warning = off
		#quote_all_identifiers = off
		#standard_conforming_strings = on
		#synchronize_seqscans = on

		# - Other Platforms and Clients -

		#transform_null_equals = off


		#------------------------------------------------------------------------------
		# ERROR HANDLING
		#------------------------------------------------------------------------------

		#exit_on_error = off\t\t\t# terminate session on any error?
		#restart_after_crash = on\t\t# reinitialize after backend crash?
		#data_sync_retry = off\t\t\t# retry or panic on failure to fsync
		\t\t\t\t\t# data?
		\t\t\t\t\t# (change requires restart)


		#------------------------------------------------------------------------------
		# CONFIG FILE INCLUDES
		#------------------------------------------------------------------------------

		# These options allow settings to be loaded from files other than the
		# default postgresql.conf.

		#include_dir = ''\t\t\t# include files ending in '.conf' from
		\t\t\t\t\t# a directory, e.g., 'conf.d'
		#include_if_exists = ''\t\t\t# include file only if it exists
		#include = ''\t\t\t\t# include file


		#------------------------------------------------------------------------------
		# CUSTOMIZED OPTIONS
		#------------------------------------------------------------------------------

		# Add settings for extensions here

		"""
}