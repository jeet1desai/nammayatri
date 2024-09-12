module Jobs.Daily where

import "dynamic-offer-driver-app" Domain.Action.Dashboard.Management.NammaTag (kaalChakraHandle)
import Kernel.External.Types (SchedulerFlow)
import Kernel.Prelude
import Kernel.Storage.ClickhouseV2 as CH
import Kernel.Storage.Esqueleto.Config
import Kernel.Utils.Common
import Lib.Scheduler
import qualified Lib.Yudhishthira.Event.KaalChakra as Event
import Lib.Yudhishthira.Storage.Beam.BeamFlow (BeamFlow)
import Lib.Yudhishthira.Types

runDailyJob ::
  ( EncFlow m r,
    CacheFlow m r,
    MonadFlow m,
    CH.HasClickhouseEnv CH.APP_SERVICE_CLICKHOUSE m,
    EsqDBFlow m r,
    EsqDBReplicaFlow m r,
    SchedulerFlow r,
    BeamFlow m r
  ) =>
  Job 'Daily ->
  m ExecutionResult
runDailyJob Job {id, jobInfo = _} = withLogTag ("JobId-" <> id.getId) do
  logInfo "Running Daily Job"
  Event.kaalChakraEvent kaalChakraHandle Daily
  ReSchedule <$> (addUTCTime 86400 <$> getCurrentTime) -- day difference
