# filename: stock_price_chart_yfinance.py
import yfinance as yf
import matplotlib.pyplot as plt

# Get historical stock data for META and TESLA
meta_data = yf.download('META', start='2022-01-01', end='2022-12-31')
tesla_data = yf.download('TSLA', start='2022-01-01', end='2022-12-31')

# Calculate daily price change
meta_data['Price Change'] = meta_data['Close'].diff()
tesla_data['Price Change'] = tesla_data['Close'].diff()

# Plot the stock price change
plt.figure(figsize=(12, 6))
plt.plot(meta_data.index, meta_data['Price Change'], label='META')
plt.plot(tesla_data.index, tesla_data['Price Change'], label='TESLA')
plt.title('META and TESLA Stock Price Change')
plt.xlabel('Date')
plt.ylabel('Price Change')
plt.legend()
plt.grid()
plt.show()