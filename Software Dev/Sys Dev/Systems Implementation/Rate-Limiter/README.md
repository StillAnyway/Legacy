# Rate Limiter using C++

### Necessity
- Prevent excessive consumption of a particular API
- Prevent secret guessing (user password during login)

### How is it done
- Use IP Address and username (in case of login) to detect requests per second
- Disallow (return 429) after threshold number of requests exceeded in the pre-defined window

### Implementation
- Input requests in a file, `requests.txt`, each line representing a new request
- Each of these requests is assumed to be sent on a periodic interval of time, defined in the code
- Code returns 200 in case of success and 429 in case of failure for every request
- Format of the request:
```
[$IP_ADDRESS]:[LOGIN/GET]?:[$USERNAME]
```
