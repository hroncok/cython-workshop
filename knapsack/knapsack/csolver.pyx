class CBruteSolver:

    '''
    Bruteforce solver for the sack problem
    '''

    def __init__(self, sack):
        '''
        Takes a sack dict as returned by DataLoader
        '''
        self.sack = sack


    def int2list(self, n):
        l = []
        for i in range(self.numitems):
            l.append(n & 1 == 1)
            n >>= 1
        return l

    def weight_and_cost(self, combo):
        weight = cost = 0
        for i, item in enumerate(self.sack['items']):
            if combo[i]:
                weight += item['weight']
                cost += item['cost']
        return weight, cost

    def solve(self):
        '''
        Main rutine, solves the problem,
        returns the combination with maximal cost and the cost
        '''
        self.numitems = len(self.sack['items'])
        self.maxcost = -1
        for num in range(2 ** self.numitems):
            combo = self.int2list(num)
            weight, cost = self.weight_and_cost(combo)
            if weight <= self.sack['capacity'] and cost > self.maxcost:
                self.maxcost = cost
                self.maxcombo = combo
        return self.maxcombo, self.maxcost
