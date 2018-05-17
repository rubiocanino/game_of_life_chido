require 'cell'
  RSpec.describe Cell do
    describe 'State of the cell' do
      cell = Cell.new
      it 'has a  state' do
        raise  unless  cell.state == ('[▓]')
      end

      it 'has a position' do
        cell.index = 1
        raise  unless  cell.index == (1)
      end

      it 'it can die' do
        raise  unless  cell.die != (cell.live)
      end

      it 'it can live' do
        raise  unless  cell.live != (cell.die)
      end

      it 'it tells you if is alive' do
        cell.die
        raise  unless  cell.is_alive?.equal?(false)
      end
    end
  end
