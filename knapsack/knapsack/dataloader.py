import json


class DataLoader:

    '''
    Class with classmethods that can load the data
    '''

    @classmethod
    def load_input_data(cls, filename):
        '''
        Load data from file a keep it in a reasonable structure

        The structure of the data is as follows:
        ID count capacity (weight cost).repeat

        We assume valid data. We'll return an iterator with dicts.
        '''
        with open(filename, 'r') as f:
            for line in f:
                yield cls.parse_input_line(line)

    @classmethod
    def parse_input_line(cls, line):
        '''
        Load one instance of a problem from a line of the input data

        Returns a dict.
        '''
        strs = line.split()
        return {
            'id': int(strs[0]),
            'count': int(strs[1]),
            'capacity': float(strs[2]),
            'items': [{'weight': float(strs[i]),
                       'cost': float(strs[i + 1])} for i in range(3, len(strs), 2)],
        }

    @classmethod
    def load_provided_results(cls, filename):
        '''
        Load results data from file a keep it in a reasonable structure

        The structure of the data is as follows:
        ID count maxcost (bool).repeat

        We assume valid data. We'll return an iterator with dicts.
        We'll only get data we need and throw away the rest.
        '''
        with open(filename, 'r') as f:
            for line in f:
                yield cls.parse_provided_results_line(line)

    @classmethod
    def parse_provided_results_line(cls, line):
        '''
        Load one instance of a result from a line of the result data

        Returns a dict.
        '''
        strs = line.split()
        return {
            'id': int(strs[0]),
            'count': int(strs[1]),
            'maxcost': float(strs[2]),
        }

    @classmethod
    def load_jsons_results(cls, filename):
        '''
        Load results data from our jsons file

        Returns a list of dicts and an average time for the file
        '''
        results = []
        avg = 0
        with open(filename, 'r') as f:
            for line in f:
                result = json.loads(line)
                if type(result) in [int, float]:
                    avg = result / len(results)
                else:
                    del result['maxcombo']  # not needed at all
                    results.append(result)
        return results, avg


def load_input(filename):
    return DataLoader.load_input_data(filename)


def load_provided_results(filename):
    return DataLoader.load_provided_results(filename)


def load_jsons_results(filename):
    return DataLoader.load_jsons_results(filename)
