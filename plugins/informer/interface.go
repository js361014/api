package informer

import (
	"context"

	"github.com/js361014/api/v2/plugins/jobs"
	"github.com/js361014/roadrunner/v2/state/process"
)

// Statistic interfaces ==============

// Informer used to get workers from particular plugin or set of plugins
type Informer interface {
	Workers() []*process.State
}

// JobsStat interface provide statistic for the jobs plugin
type JobsStat interface {
	// JobsState returns slice with the attached drivers information
	JobsState(ctx context.Context) ([]*jobs.State, error)
}
