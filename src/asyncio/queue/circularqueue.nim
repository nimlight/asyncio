import ./basic


func newCircularQueue*[Capacity: static[int], T](): CircularQueue[Capacity, T] =
  CircularQueue[Capacity, T]()

func peekQueue*[Capacity: static[int], T](q: CircularQueue[Capacity, T]): lent T =
  if q.isEmpty:
    return
  if q.head < q.Capacity:
    result = q.data[q.head]
  else:
    result = q.data[q.head-q.Capacity]

func deQueue*[Capacity: static[int], T](q: var CircularQueue[Capacity, T]): owned T =
  if q.isEmpty:
    return
  if q.head < q.Capacity:
    result = move q.data[q.head]
  else:
    result = move q.data[q.head-q.Capacity]
  inc(q.head)
  if q.head == 2 * q.Capacity:
    q.head = 0

proc enQueue*[Capacity: static[int], T](q: var CircularQueue[Capacity, T], v: sink T) =
  if q.isFull:
    return
  if q.tail < q.Capacity:
    q.data[q.tail] = v
  else:
    q.data[q.tail-q.Capacity] = v
  inc(q.tail)
  if q.tail == 2 * q.Capacity:
    q.tail = 0
