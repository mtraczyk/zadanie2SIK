#include "event.h"
#include "parsing_functionalities.h"

namespace {
  uint32_t crc32(std::string const &input) {
    return 0;
  }

  void generateEventInfo(std::string &datagram, uint32_t eventNo, uint8_t eventType) {
    auto byteArray = toByte(eventNo);
    datagram = std::string(byteArray.begin(), byteArray.end());
    byteArray = toByte(eventType);
    datagram += std::string(byteArray.begin(), byteArray.end());
  }

  template<typename T>
  void addNumber(std::string &datagram, T number) {
    auto byteArray = toByte(number);
    datagram += std::string(byteArray.begin(), byteArray.end());
  }

  std::string finalDatagram(std::string &eventDatagramPart) {
    std::string eventPartLength;
    uint32_t len = eventDatagramPart.size();

    addNumber(eventDatagramPart, crc32(eventDatagramPart));
    addNumber(eventPartLength, len);

    return eventPartLength + eventDatagramPart;
  }
}

std::string NewGame::getByteRepresentation() const noexcept {
  std::string eventDatagramPart; // variable to store part of datagram data
  generateEventInfo(eventDatagramPart, eventNo, eventType);

  addNumber(eventDatagramPart, maxx);
  addNumber(eventDatagramPart, maxy);
  for (auto const &u : playersNames) {
    eventDatagramPart += u + '\0';
  }

  return finalDatagram(eventDatagramPart);
}

std::string Pixel::getByteRepresentation() const noexcept {
  std::string eventDatagramPart; // variable to store part of datagram data
  std::string eventPartLength;
  generateEventInfo(eventDatagramPart, eventNo, eventType);

  addNumber(eventDatagramPart, x);
  addNumber(eventDatagramPart, y);

  return finalDatagram(eventDatagramPart);
}

std::string PlayerEliminated::getByteRepresentation() const noexcept {
  std::string eventDatagramPart; // variable to store part of datagram data
  std::string eventPartLength;
  generateEventInfo(eventDatagramPart, eventNo, eventType);

  addNumber(eventDatagramPart, playerNum);

  return finalDatagram(eventDatagramPart);
}

std::string GameOver::getByteRepresentation() const noexcept {
  std::string eventDatagramPart; // variable to store part of datagram data
  std::string eventPartLength;
  generateEventInfo(eventDatagramPart, eventNo, eventType);

  return finalDatagram(eventDatagramPart);
}
