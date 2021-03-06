import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia? usecase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository!);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: 'test');

  test(
    'should get trivia fot the number from repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository!.getConcreteNumberTrivia(2))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));
      // act
      final result = await usecase!.execute(number: tNumber);
      // assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository!.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
