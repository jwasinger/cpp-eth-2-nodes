FROM ethereum/cpp-build-env

USER root

# Prebuild cpp-ethereum for caching
RUN git clone --recursive https://github.com/ethereum/cpp-ethereum --single-branch --recursive  \
    && cd cpp-ethereum && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DTOOLS=Off -DTESTS=Off \
    && make -j8

# See https://github.com/ethereum/cpp-ethereum/issues/3300
# Using more than j4 can cause failures randomly

# ADD config.json /config.json

# ADD ewasm-testnet-cpp-config.json /ewasm-testnet-cpp-config.json
# ADD cpp-eth.sh /cpp-eth.sh

# Export the usual networking ports to allow outside access to the node
# EXPOSE 8545 30303

# ENTRYPOINT ["/cpp-eth.sh"]

RUN cd cpp-ethereum && git remote add jwasinger https://github.com/jwasinger/cpp-ethereum && git fetch jwasinger && git checkout testy && cd build && cmake .. && make -j8
