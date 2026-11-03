Each output traces back to a row of the design diagram (the captions name the part where one applies). Read each in the same four steps. First, find its row in the diagram, which says what was simulated and what was varied. Second, work out what one point or one table entry is, usually one combination of the varied factors, averaged over replicates. Third, identify the reference value that would hold if nothing were wrong, shown as a dashed or grey line wherever possible. Fourth, look for where the results leave that reference, and for which settings they do. The outputs report three kinds of quantity.

- **Bias** is the average of an estimate minus its true value. When the truth is no difference, any average difference from 0 is a spurious difference created by the problem under study.
- **Level** is how often a test rejects when there is truly nothing to find. A correct test at 0.05 rejects 5% of the time, so a rate above 0.05 means too many false alarms.
- **Power** is how often a test rejects when there is a real effect. More is better, but only when the level is not inflated, because a test that rejects too often also looks powerful.

All rates and averages come from simulation, so each carries Monte Carlo error. That is why the figures show bars or a grey band, and why small differences should not be over-read.
